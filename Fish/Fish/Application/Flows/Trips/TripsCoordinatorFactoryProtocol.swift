protocol TripsCoordinatorFactoryProtocol {
    func makeTripsCoordinator() -> TripsCoordinatorProtocol
}

// MARK: - CoordinatorFactory extension
extension CoordinatorFactory: TripsCoordinatorFactoryProtocol {
    func makeTripsCoordinator() -> TripsCoordinatorProtocol {
        TripsCoordinator(navigationPresenter: makeNavigationPresenter(),
                         offersRepository: makeOffersRepository(),
                         moduleFactory: makeModuleFactory())
    }
}
