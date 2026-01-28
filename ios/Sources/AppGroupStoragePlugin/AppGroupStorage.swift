import Foundation

@objc public class AppGroupStorage: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
}
