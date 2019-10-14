import Common
import UIKit

final class InTheCityCoordinator: Coordinator {
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
        presentable.title = "Florianópolis"

        navigationPresenter.setRoot(presentable, animated: false)

        presentable.showLoading()
        offersRepository.fetchCityOffers { result in
            presentable.hideLoading()

            switch result {
            case let .success(offers):
                presentable.show(offers: offers)
            case let .failure(error):
                print("Error while trying to fetch offers in the city: \(error)")
            }
        }
    }
}

// MARK: - InTheCityCoordinatorProtocol extension
extension InTheCityCoordinator: InTheCityCoordinatorProtocol {
    func toPresent() -> ScreenProtocol { navigationPresenter.rootScreen }
}
