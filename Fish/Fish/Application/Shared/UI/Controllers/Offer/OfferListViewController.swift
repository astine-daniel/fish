import UIKit

final class OfferListViewController: UIViewController {
    typealias View = UIView & OfferListViewProtocol

    // MARK: - Properties
    private let _view: View

    // swiftlint:disable:next weak_delegate
    private let layoutDelegate = OfferListLayoutDelegate()
    private let titleBarButton = TitleBarButton()
    private var offers: [Model.Offer] = [] {
        didSet {
            _view.collectionView.reloadData()
        }
    }

    override var title: String? {
        didSet {
            handleTitleBarButton()
        }
    }

    // MARK: - Initializers
    required init(view: View) {
        _view = view

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Strings.Error.Fatal.notImplemented("init(coder:)"))
    }

    // MARK: - View lifecycle
    override func loadView() {
        view = _view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

        handleTitleBarButton()
        showRightBarButtons()
    }

    // MARK: - Methods
    func showLoading() {
        _view.startLoadingIndicator()
    }

    func hideLoading() {
        _view.stopLoadingIndicator()
    }

    func show(offers: [Model.Offer]) {
        self.offers = offers
    }
}

// MARK: - UICollectionViewDataSource extension
extension OfferListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        offers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: OfferCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(with: offers[indexPath.row])

        return cell
    }
}

// MARK: - Private extension
private extension OfferListViewController {
    func setupView() {
        _view.collectionView.dataSource = self
        _view.collectionView.delegate = layoutDelegate
    }

    func handleTitleBarButton() {
        navigationItem.titleView = UIView()

        guard let title = title else {
            navigationItem.leftBarButtonItem = nil
            return
        }

        titleBarButton.title = title
        let barButton = UIBarButtonItem(customView: titleBarButton)
        navigationItem.leftBarButtonItem = barButton
    }

    func showRightBarButtons() {
        let filterBarButton = UIBarButtonItem(customView: UIImageView(image: Assets.Common.filter.image))
        let favoriteBarButton = UIBarButtonItem(customView: UIImageView(image: Assets.Common.heartBold.image))

        navigationItem.rightBarButtonItems = [favoriteBarButton, filterBarButton]
    }
}
