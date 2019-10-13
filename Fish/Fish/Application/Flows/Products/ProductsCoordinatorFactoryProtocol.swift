protocol ProductsCoordinatorFactoryProtocol {
    func makeProductsCoordinator() -> ProductsCoordinatorProtocol
}

// MARK: - CoordinatorFactory extension
extension CoordinatorFactory: ProductsCoordinatorFactoryProtocol {
    func makeProductsCoordinator() -> ProductsCoordinatorProtocol {
        ProductsCoordinator(navigationPresenter: makeNavigationPresenter())
    }
}
