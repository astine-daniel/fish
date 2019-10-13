import Common
import UIKit

final class HomeCoordinator: Coordinator {
    typealias CoordinatorFactory = InTheCityCoordinatorFactoryProtocol
        & TripsCoordinatorFactoryProtocol
        & ProductsCoordinatorFactoryProtocol

    // MARK: - Properties
    private var tabPresenter: TabPresenterProtocol
    private let coordinatorFactory: CoordinatorFactory

    // MARK: - Initialization
    init(tabPresenter: TabPresenterProtocol, coordinatorFactory: CoordinatorFactory) {
        self.tabPresenter = tabPresenter
        self.coordinatorFactory = coordinatorFactory

        super.init()

        self.tabPresenter.didSelectTabAtIndex = { [weak self] index in
            guard let self = self else { return }
            self.didSelectTab(at: index)
        }
    }

    override func start() {
        let items: [TabItem<UIImage>] = [
            .init(title: Strings.inTheCity,
                  icon: Assets.Flows.InTheCity.inTheCityIcon.image,
                  selectedIcon: Assets.Flows.InTheCity.inTheCityIconHighlighted.image),
            .init(title: Strings.trips,
                  icon: Assets.Flows.Trips.tripsIcon.image,
                  selectedIcon: Assets.Flows.Trips.tripsIconHighlighted.image),
            .init(title: Strings.products,
                  icon: Assets.Flows.Products.productsIcon.image,
                  selectedIcon: Assets.Flows.Products.productsIconHighlighted.image)
        ]

        let modules: [CoordinatorProtocol & Presentable] = [
            coordinatorFactory.makeInTheCityCoordinator(),
            coordinatorFactory.makeTripsCoordinator(),
            coordinatorFactory.makeProductsCoordinator()
        ]

        modules.forEach { add(child: $0) }

        tabPresenter.show(tabs: modules, items: items, animated: false)
    }
}

// MARK: - HomeCoordinatorProtocol extension
extension HomeCoordinator: HomeCoordinatorProtocol {
    func toPresent() -> ScreenProtocol { tabPresenter.rootScreen }
}

// MARK: - Private extension
private extension HomeCoordinator {
    func didSelectTab(at index: Int) {
        guard childCoordinators.count > index else { return }
        childCoordinators[index].start()
    }
}
