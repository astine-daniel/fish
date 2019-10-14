import UIKit

final class OfferListView: UIView {
    // MARK: - Initialization
    required init() {
        super.init(frame: .zero)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Strings.Error.Fatal.notImplemented("init(coder:)"))
    }

    // MARK: - Properties
    private let activityIndicatorView: UIActivityIndicatorView = {
        if #available(iOS 13.0, *) {
            return UIActivityIndicatorView(style: .medium)
        }

        return UIActivityIndicatorView(style: .gray)
    }()

    private let _collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(cellType: OfferCollectionViewCell.self)

        return collectionView
    }()
}

// MARK: - OfferListViewProtocol extension
extension OfferListView: OfferListViewProtocol {
    var collectionView: UICollectionView { _collectionView }

    func startLoadingIndicator() {
        activityIndicatorView.startAnimating()
    }

    func stopLoadingIndicator() {
        activityIndicatorView.stopAnimating()
    }
}

// MARK: - Private extension
private extension OfferListView {
    // MARK: - Setup
    func setup() {
        backgroundColor = Assets.Colors.wildSand.color
        _collectionView.backgroundColor = Assets.Colors.wildSand.color

        setupSubviews()
        setupConstraints()
    }

    func setupSubviews() {
        addSubview(activityIndicatorView)
        addSubview(_collectionView)
    }

    func setupConstraints() {
        setupActivityIndicatorViewConstraints()
        setupCollectionViewConstraints()
    }

    // MARK: - Constraints
    func setupActivityIndicatorViewConstraints() {
        activityIndicatorView.layout {
            $0.centerXAnchor == centerXAnchor
            $0.centerYAnchor == centerYAnchor
        }
    }

    func setupCollectionViewConstraints() {
        _collectionView.layout {
            $0.top == safeAreaLayoutGuide.topAnchor
            $0.trailing == safeAreaLayoutGuide.trailingAnchor
            $0.bottom == bottomAnchor
            $0.leading == safeAreaLayoutGuide.leadingAnchor
        }
    }
}
