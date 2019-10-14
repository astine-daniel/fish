import UIKit

final class TabBarController: UITabBarController {
    // MARK: - Managing View
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = Assets.Colors.flamingo.color
    }
}
