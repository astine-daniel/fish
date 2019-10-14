import Common

protocol OfferListViewPresentable: Presentable {
    var title: String? { get set }

    func showLoading()
    func hideLoading()

    func show(offers: [Model.Offer])
}
