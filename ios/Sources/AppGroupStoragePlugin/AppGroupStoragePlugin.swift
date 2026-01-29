import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(AppGroupStoragePlugin)
public class AppGroupStoragePlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "AppGroupStoragePlugin"
    public let jsName = "AppGroupStorage"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "echo", returnType: CAPPluginReturnPromise)
    ]
    private let implementation = AppGroupStorage()

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }


private func containerURL(for groupId: String) throws -> URL {
        if let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupId) {
            return url
        }
        throw NSError(domain: "AppGroupFilesPlugin", code: 1,
                      userInfo: [NSLocalizedDescriptionKey: "App Group container not found for \(groupId)"])
    }

    private func ensureImagesDir(in container: URL) throws -> URL {
        let dir = container.appendingPathComponent("SharedImages", isDirectory: true)
        try FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir
    }

    private func sanitizeFilename(_ raw: String) -> String {
        // Prevent path traversal and weird characters
        return (raw as NSString).lastPathComponent.replacingOccurrences(of: ":", with: "_")
    }

    // MARK: - API

    @objc func saveImage(_ call: CAPPluginCall) {
        guard let groupId = call.getString("groupId"),
              let filenameRaw = call.getString("filename"),
              let b64 = call.getString("dataBase64"),
              let data = Data(base64Encoded: b64, options: .ignoreUnknownCharacters)
        else {
            call.reject("Missing or invalid parameters")
            return
        }

        let filename = sanitizeFilename(filenameRaw)

        do {
            let container = try containerURL(for: groupId)
            let imagesDir = try ensureImagesDir(in: container)
            let fileURL = imagesDir.appendingPathComponent(filename)

            // Optional: ensure extension is image-ish
            /* if let ext = fileURL.pathExtension.lowercased() as String?,
               !["png", "jpg", "jpeg", "heic", "webp"].contains(ext) {
                call.reject("Unsupported file extension: .\(ext)")
                return
            } */

            // Atomic write to avoid partial files
            try data.write(to: fileURL, options: [.atomic])

            call.resolve([
                "path": fileURL.path
            ])
        } catch {
            call.reject("Write error: \(error.localizedDescription)")
        }
    }

    @objc func listImages(_ call: CAPPluginCall) {
        guard let groupId = call.getString("groupId") else {
            call.reject("groupId is required"); return
        }
        do {
            let container = try containerURL(for: groupId)
            let imagesDir = try ensureImagesDir(in: container)

            let items = try FileManager.default.contentsOfDirectory(at: imagesDir, includingPropertiesForKeys: [.contentModificationDateKey, .fileSizeKey], options: [.skipsHiddenFiles])

            //let allowed = Set(["png","jpg","jpeg","heic","webp"])
            let files = try items
                //.filter { allowed.contains($0.pathExtension.lowercased()) }
                .map { url -> [String: Any] in
                    let values = try url.resourceValues(forKeys: [.contentModificationDateKey, .fileSizeKey])
                    return [
                        "name": url.lastPathComponent,
                        "path": url.path,
                        "size": values.fileSize ?? 0,
                        "mtime": Int((values.contentModificationDate ?? Date()).timeIntervalSince1970 * 1000)
                    ]
                }

            call.resolve(["files": files])
        } catch {
            call.reject("List error: \(error.localizedDescription)")
        }
    }

    @objc func readImageAsBase64(_ call: CAPPluginCall) {
        guard let groupId = call.getString("groupId"),
              let filenameRaw = call.getString("filename")
        else { call.reject("groupId and filename are required"); return }

        let filename = sanitizeFilename(filenameRaw)

        do {
            let container = try containerURL(for: groupId)
            let imagesDir = try ensureImagesDir(in: container)
            let fileURL = imagesDir.appendingPathComponent(filename)

            let data = try Data(contentsOf: fileURL)
            call.resolve(["data": data.base64EncodedString()])
        } catch {
            call.reject("Read error: \(error.localizedDescription)")
        }
    }

    @objc func copyToTempForWebView(_ call: CAPPluginCall) {
        guard let groupId = call.getString("groupId"),
              let filenameRaw = call.getString("filename")
        else { call.reject("groupId and filename are required"); return }

        let filename = sanitizeFilename(filenameRaw)

        do {
            let container = try containerURL(for: groupId)
            let imagesDir = try ensureImagesDir(in: container)
            let srcURL = imagesDir.appendingPathComponent(filename)

            let tmpURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
                .appendingPathComponent("shared-copy-\(UUID().uuidString)")
                .appendingPathExtension((srcURL.pathExtension))

            try FileManager.default.copyItem(at: srcURL, to: tmpURL)

            // We can’t call Capacitor.convertFileSrc here in native; do it on the JS side.
            call.resolve(["path": tmpURL.path])
        } catch {
            call.reject("Copy error: \(error.localizedDescription)")
        }
    }

}
