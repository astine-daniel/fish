#if canImport(UIKit)

import UIKit

public final class NavigationControllerPresenter: NSObject {
    public typealias NavigationScreen = UINavigationController & ScreenProtocol

    // MARK: - Properties
    private (set) var navigationScreen: NavigationScreen

    private var completionsWhenPopped: [UIViewController: Completion]
    private var completions: [UIViewController: Completion]

    private weak var snapshotView: UIView?

    // MARK: - Initialization
    public required init(navigationScreen: NavigationScreen) {
        self.navigationScreen = navigationScreen
        completionsWhenPopped = [:]
        completions = [:]

        super.init()

        navigationScreen.delegate = self
    }
}

// MARK: - NavigationPresenterProtocol extension
extension NavigationControllerPresenter: NavigationPresenterProtocol {
    public var rootScreen: ScreenProtocol { navigationScreen }

    public func setRoot(_ module: Module, animated: Bool) {
        completionsWhenPopped.forEach { $0.value() }
        completionsWhenPopped.removeAll()

        let module = module.toPresent()
        navigationScreen.present(module, style: .main(animated: animated))
    }

    public func show(_ module: Module, animated: Bool, completionWhenPopped: Completion?) {
        guard navigationScreen.viewControllers.isEmpty == false else {
            setRoot(module, animated: animated)
            return
        }

        guard let viewController = module.toPresent() as? (UIViewController & ScreenProtocol) else { return }
        if let completionWhenPopped = completionWhenPopped {
            completionsWhenPopped[viewController] = completionWhenPopped
        }

        navigationScreen.present(viewController, style: .show(animated: animated))
    }

    public func backTo(_ module: Module,
                       animatedWith animation: NavigationPresenterBackAnimation = .normal,
                       completion: Completion?) {
        guard navigationScreen.viewControllers.count > 1 else { return }

        guard let viewController = module.toPresent() as? UIViewController else { return }
        backTo(viewController: viewController, animatedWith: animation, completion: completion)
    }

    public func backToRootModule(animatedWith animation: NavigationPresenterBackAnimation, completion: Completion?) {
        guard navigationScreen.viewControllers.count > 1,
            let viewController = navigationScreen.viewControllers.first else {
                return
        }

        backTo(viewController: viewController, animatedWith: animation, completion: completion)
    }

    public func present(_ module: Module, animated: Bool) {
        let module = module.toPresent()
        navigationScreen.present(module, style: .modal(animated: animated))
    }

    public func dismiss(_ module: Module, animated: Bool) {
        navigationScreen.dismiss(animated: animated)
    }
}

// MARK: - UINavigationControllerDelegate extension
extension NavigationControllerPresenter: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                                     didShow viewController: UIViewController,
                                     animated: Bool) {
        runCompletion(for: viewController)

        guard let poppedViewController = navigationController
            .transitionCoordinator?.viewController(forKey: .from) else {
                return
        }

        guard navigationController.viewControllers.contains(poppedViewController) == false else { return }

        runCompletionWhenPopped(for: poppedViewController)
    }
}

// MARK: - Private extension
private extension NavigationControllerPresenter {
    func runCompletionWhenPopped(for viewController: UIViewController) {
        guard let completion = completionsWhenPopped.removeValue(forKey: viewController) else { return }
        completion()
    }

    func runCompletion(for viewController: UIViewController) {
        guard let completion = completions.removeValue(forKey: viewController) else { return }
        completion()
    }

    func backTo(viewController: UIViewController,
                animatedWith animation: NavigationPresenterBackAnimation,
                completion: Completion?) {
        var customCompletion: Completion = {
            completion?()
        }

        switch animation {
        case .none:
            completions[viewController] = customCompletion
            backTo(viewController: viewController, animated: false)
        case .normal:
            completions[viewController] = customCompletion
            backTo(viewController: viewController)
        case .fade:
            customCompletion = { [weak self] in
                guard let self = self else { return }

                self.completeBackTransitionWithFadeAnimation()
                completion?()
            }

            completions[viewController] = customCompletion
            fadeTo(viewController: viewController)
        }
    }

    func backTo(viewController: UIViewController?, animated: Bool = true) {
        guard let viewController = viewController else { return }

        guard navigationScreen.viewControllers.contains(viewController) else {
            backTo(viewController: viewController.parent, animated: animated)
            return
        }

        guard let poppedViewControllers = navigationScreen
            .popToViewController(viewController, animated: animated) else {
                return
        }

        poppedViewControllers.forEach { runCompletionWhenPopped(for: $0) }
    }

    func fadeTo(viewController: UIViewController) {
        guard let snapshotView = navigationScreen.visibleViewController?
            .view.snapshotView(afterScreenUpdates: true) else { return }

        navigationScreen.view.addSubview(snapshotView)
        self.snapshotView = snapshotView

        backTo(viewController: viewController, animated: false)
    }

    func completeBackTransitionWithFadeAnimation() {
        guard let snapshotView = snapshotView else { return }

        UIView.animate(withDuration: 1.0, animations: {
            snapshotView.alpha = 0.0
        }, completion: { _ in
            snapshotView.removeFromSuperview()
        })
    }
}

#endif
