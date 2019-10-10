// swiftlint:disable:this file_name

#if canImport(UIKit)

import UIKit

// MARK: - UIWindow
extension UIWindow: Presentable {
    public func toPresent() -> ScreenProtocol { rootViewController! }
}

// MARK: - UIViewController
extension UIViewController: Presentable {
    public func toPresent() -> ScreenProtocol { self }
}

#endif
