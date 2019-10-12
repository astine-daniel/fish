import Common
import UIKit

final class HomeCoordinator: Coordinator {
    // MARK: - Properties
    private let tabPresenter: TabPresenterProtocol

    // MARK: - Initialization
    init(tabPresenter: TabPresenterProtocol) {
        self.tabPresenter = tabPresenter
    }

    override func start() {
        let items: [TabItem<UIImage>] = [
            .init(title: "Na cidade", icon: nil, selectedIcon: nil),
            .init(title: "Viagens", icon: nil, selectedIcon: nil),
            .init(title: "Produtos", icon: nil, selectedIcon: nil)
        ]

        let modules: [Presentable] = [
            UIViewController(),
            UIViewController(),
            UIViewController()
        ]

        tabPresenter.show(tabs: modules, items: items, animated: false)
    }
}

// MARK: - TripsCoordinatorProtocol extension
extension HomeCoordinator: HomeCoordinatorProtocol {
    func toPresent() -> ScreenProtocol {
        tabPresenter.rootScreen
    }
}
