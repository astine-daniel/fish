import UIKit

final class NavigationController: UINavigationController {
    // MARK: - Managing View
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = Assets.Colors.denim.color
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        setBackButton(makeBackButtonWithoutTitle(), in: viewController)
        super.pushViewController(viewController, animated: animated)
    }

    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        viewControllers.forEach { setBackButton(makeBackButtonWithoutTitle(), in: $0) }
        super.setViewControllers(viewControllers, animated: animated)
    }
}

// MARK: - Private extension
private extension NavigationController {
    func makeBackButtonWithoutTitle() -> UIBarButtonItem {
        return UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }

    func setBackButton(_ backButton: UIBarButtonItem, in viewController: UIViewController) {
        viewController.navigationItem.backBarButtonItem = backButton
    }
}
