import Common
import UIKit

final class ProductsCoordinator: Coordinator {
    // MARK: - Properties
    private let navigationPresenter: NavigationPresenterProtocol
    private var started: Bool = false

    // MARK: - Initialization
    init(navigationPresenter: NavigationPresenterProtocol) {
        self.navigationPresenter = navigationPresenter

        super.init()
    }

    // MARK: - Methods
    override func start() {
        guard started == false else { return }
        started.toggle()

        let controller = OfferListViewController(view: OfferListView())
        controller.title = Strings.products

        navigationPresenter.setRoot(controller, animated: false)
    }
}

// MARK: - ProductsCoordinatorProtocol extension
extension ProductsCoordinator: ProductsCoordinatorProtocol {
    func toPresent() -> ScreenProtocol { navigationPresenter.rootScreen }
}
