protocol HomeCoordinatorFactoryProtocol {
    func makeHomeCoordinator() -> HomeCoordinatorProtocol
}

// MARK: - CoordinatorFactory extension
extension CoordinatorFactory: HomeCoordinatorFactoryProtocol {
    func makeHomeCoordinator() -> HomeCoordinatorProtocol {
        HomeCoordinator(tabPresenter: makeTabPresenter(), coordinatorFactory: self)
    }
}
