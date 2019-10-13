import Common
import UIKit

final class CoordinatorFactory {
    func makeNavigationPresenter() -> NavigationPresenterProtocol {
        NavigationControllerPresenter(navigationScreen: NavigationController())
    }

    func makeTabPresenter() -> TabPresenterProtocol {
        TabBarControllerPresenter(tabScreen: TabBarController())
    }
}
