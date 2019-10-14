import Common
import UIKit

final class ProductsCoordinator: Coordinator {
    typealias ModuleFactory = OfferListModuleFactoryProtocol

    // MARK: - Properties
    private let navigationPresenter: NavigationPresenterProtocol
    private let offersRepository: OffersRepositoryProtocol
    private let moduleFactory: ModuleFactory

    private var started: Bool = false

    // MARK: - Initialization
    init(navigationPresenter: NavigationPresenterProtocol,
         offersRepository: OffersRepositoryProtocol,
         moduleFactory: ModuleFactory) {
        self.navigationPresenter = navigationPresenter
        self.offersRepository = offersRepository
        self.moduleFactory = moduleFactory

        super.init()
    }

    // MARK: - Methods
    override func start() {
        guard started == false else { return }
        started.toggle()

        let presentable = moduleFactory.makeOfferListView()
        presentable.title = Strings.products

        navigationPresenter.setRoot(presentable, animated: false)

        presentable.showLoading()
        offersRepository.fetchProducts { result in
            presentable.hideLoading()

            switch result {
            case let .success(offers):
                presentable.show(offers: offers)
            case let .failure(error):
                print("Error while trying to fetch products: \(error)")
            }
        }
    }
}

// MARK: - ProductsCoordinatorProtocol extension
extension ProductsCoordinator: ProductsCoordinatorProtocol {
    func toPresent() -> ScreenProtocol { navigationPresenter.rootScreen }
}
