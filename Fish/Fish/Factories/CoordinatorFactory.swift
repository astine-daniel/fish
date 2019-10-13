import Common
import UIKit

final class CoordinatorFactory {
    func makeNavigationPresenter() -> NavigationPresenterProtocol {
        NavigationControllerPresenter(navigationScreen: UINavigationController())
    }

    func makeTabPresenter() -> TabPresenterProtocol {
        TabBarControllerPresenter(tabScreen: TabBarController())
    }
}
