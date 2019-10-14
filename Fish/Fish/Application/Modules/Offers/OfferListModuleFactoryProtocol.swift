protocol OfferListModuleFactoryProtocol {
    func makeOfferListView() -> OfferListViewPresentable
}

// MARK: - ModuleFactory extension
extension ModuleFactory: OfferListModuleFactoryProtocol {
    func makeOfferListView() -> OfferListViewPresentable {
        OfferListViewController(view: OfferListView())
    }
}

// MARK: - OfferListViewController extension
extension OfferListViewController: OfferListViewPresentable { }
