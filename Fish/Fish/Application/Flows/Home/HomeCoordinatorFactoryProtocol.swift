import Common
import UIKit

protocol HomeCoordinatorFactoryProtocol {
    func makeHomeCoordinator() -> HomeCoordinatorProtocol
}

// MARK: - CoordinatorFactory extension
extension CoordinatorFactory: HomeCoordinatorFactoryProtocol {
    func makeHomeCoordinator() -> HomeCoordinatorProtocol {
        HomeCoordinator(tabPresenter: TabBarControllerPresenter(tabScreen: UITabBarController()))
    }
}
