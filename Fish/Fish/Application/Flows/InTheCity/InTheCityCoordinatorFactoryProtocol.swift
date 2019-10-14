protocol InTheCityCoordinatorFactoryProtocol {
    func makeInTheCityCoordinator() -> InTheCityCoordinatorProtocol
}

// MARK: - CoordinatorFactory extension
extension CoordinatorFactory: InTheCityCoordinatorFactoryProtocol {
    func makeInTheCityCoordinator() -> InTheCityCoordinatorProtocol {
        InTheCityCoordinator(navigationPresenter: makeNavigationPresenter(),
                             offersRepository: makeOffersRepository(),
                             moduleFactory: makeModuleFactory())
    }
}
