#if canImport(UIKit)

import UIKit

// MARK: - UIWindow
extension UIWindow: ScreenProtocol {
    public func present(_ screen: ScreenProtocol, style: ScreenPresentStyle) {
        guard let viewController = screen as? UIViewController else { return }

        switch style {
        case let .modal(animated):
            guard let rootViewController = rootViewController else {
                changeRootViewController(to: viewController, animated: true)
                return
            }

            rootViewController.present(viewController, animated: animated)
        case let .show(animated),
             let .main(animated):
            changeRootViewController(to: viewController, animated: animated)
        }
    }

    public func dismiss(animated: Bool) {
        rootViewController?.dismiss(animated: animated)
    }
}

private extension UIWindow {
    func changeRootViewController(to viewController: UIViewController, animated: Bool) {
        guard rootViewController != nil, animated else {
            rootViewController = viewController
            return
        }

        let snapView = snapshotView(afterScreenUpdates: true)!

        viewController.view.addSubview(snapView)
        rootViewController = viewController

        isUserInteractionEnabled = false
        UIView.animate(withDuration: 1.0, animations: {
            snapView.alpha = 0.0
        }, completion: { _ in
            snapView.removeFromSuperview()
            self.isUserInteractionEnabled = true
        })
    }
}

// MARK: - UIViewController
extension ScreenProtocol where Self: UIViewController {
    public func present(_ screen: ScreenProtocol, style: ScreenPresentStyle) {
        guard let viewController = screen as? UIViewController else { return }

        switch style {
        case let .modal(animated),
             let .main(animated):
            present(viewController, animated: animated)
        default:
            return
        }
    }

    public func dismiss(animated: Bool) {
        dismiss(animated: animated)
    }
}

// MARK: - UINavigationController
extension ScreenProtocol where Self: UINavigationController {
    public func present(_ screen: ScreenProtocol, style: ScreenPresentStyle) {
        guard let viewController = screen as? UIViewController else { return }

        switch style {
        case let .main(animated):
            setViewControllers([viewController], animated: animated)
        case let .modal(animated):
            visibleViewController?.present(viewController, animated: animated)
        case let .show(animated):
            pushViewController(viewController, animated: animated)
        }
    }

    public func dismiss(animated: Bool) {
        visibleViewController?.dismiss(animated: true)
    }
}

extension UIViewController: ScreenProtocol { }

#endif
