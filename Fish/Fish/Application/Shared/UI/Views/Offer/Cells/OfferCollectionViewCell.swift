import UIKit

final class OfferCollectionViewCell: UICollectionViewCell {
    // MARK: - Initialization
    required convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Strings.Error.Fatal.notImplemented("init(coder:)"))
    }

    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.image = nil

        shortTitleLabel.text = nil
        topOfferContainerStackView.isHidden = true

        favoriteButton.isSelected = false

        titleLabel.text = nil

        fromPriceLabel.text = Strings.Common.fromPrice
        priceLabel.attributedText = nil
    }

    // MARK: - Properties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .center

        return imageView
    }()

    private let shortTitleContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6.0

        return stackView
    }()

    private let topOfferContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.isHidden = true
        stackView.spacing = 6.0

        return stackView
    }()

    private let topOfferIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.Common.star.image

        return imageView
    }()

    private let topOfferLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.text = Strings.Common.top.uppercased()
        label.textColor = .white

        return label
    }()

    private let shortTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        label.textColor = .white

        return label
    }()

    private let favoriteContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.layer.cornerRadius = 22.5
        view.layer.masksToBounds = true

        return view
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(Assets.Common.heart.image, for: .normal)
        button.setImage(Assets.Common.heartHighlighted.image, for: .selected)
        button.setImage(Assets.Common.heartHighlighted.image, for: .highlighted)

        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0)
        label.numberOfLines = 2
        label.textColor = .black

        return label
    }()

    private let fromPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12.0, weight: .light)
        label.text = Strings.Common.fromPrice
        label.textColor = Assets.Colors.dustyGray.color

        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        label.textAlignment = .right
        label.textColor = Assets.Colors.flamingo.color

        return label
    }()
}

// MARK: - Reusable extension
extension OfferCollectionViewCell: Reusable { }

// MARK: - Private extension
private extension OfferCollectionViewCell {
    // MARK: - Setup
    func setup() {
        backgroundColor = .white

        setupSubviews()
        setupConstraints()
    }

    func setupSubviews() {
        contentView.addSubview(imageView)

        contentView.addSubview(shortTitleContainerStackView)
        shortTitleContainerStackView.addArrangedSubview(topOfferContainerStackView)
        shortTitleContainerStackView.addArrangedSubview(shortTitleLabel)

        topOfferContainerStackView.addArrangedSubview(topOfferIconImageView)
        topOfferContainerStackView.addArrangedSubview(topOfferLabel)

        contentView.addSubview(favoriteContainerView)
        favoriteContainerView.addSubview(favoriteButton)

        contentView.addSubview(titleLabel)

        contentView.addSubview(fromPriceLabel)
        contentView.addSubview(priceLabel)
    }

    func setupConstraints() {
        setupImageViewConstraints()
        setupShortTitleContainerStackViewConstraints()
        setupFavoriteConstraints()
        setupTitleLabelConstraints()
        setupPricesConstraints()
    }

    // MARK: - Constraints
    func setupImageViewConstraints() {
        imageView.layout {
            $0.top == contentView.topAnchor
            $0.trailing == contentView.trailingAnchor
            $0.bottom == contentView.bottomAnchor - 64.0
            $0.leading == contentView.leadingAnchor
        }
    }

    func setupShortTitleContainerStackViewConstraints() {
        shortTitleContainerStackView.layout {
            $0.trailing >= favoriteContainerView.leadingAnchor - 16.0
            $0.bottom == imageView.bottomAnchor - 18.0
            $0.leading == imageView.leadingAnchor + 16.0
        }

        topOfferIconImageView.layout {
            $0.width == 22.0
            $0.height == 22.0
        }
    }

    func setupFavoriteConstraints() {
        favoriteContainerView.layout {
            $0.trailing == contentView.trailingAnchor - 16.0
            $0.bottom == imageView.bottomAnchor - 18.0
            $0.width == 45.0
            $0.height == 45.0
        }

        favoriteButton.layout {
            $0.width == 22.0
            $0.height == 22.0
            $0.centerXAnchor == favoriteContainerView.centerXAnchor
            $0.centerYAnchor == favoriteContainerView.centerYAnchor
        }
    }

    func setupTitleLabelConstraints() {
        titleLabel.layout {
            $0.top == imageView.bottomAnchor + 16.0
            $0.trailing <= fromPriceLabel.leadingAnchor - 16.0
            $0.trailing <= priceLabel.leadingAnchor - 16.0
            $0.bottom >= contentView.bottomAnchor - 16.0
            $0.leading == contentView.leadingAnchor + 16.0
        }
    }

    func setupPricesConstraints() {
        fromPriceLabel.layout {
            $0.top == imageView.bottomAnchor + 14.0
            $0.trailing == contentView.trailingAnchor - 16.0
        }

        priceLabel.layout {
            $0.top == fromPriceLabel.bottomAnchor + 6.0
            $0.trailing == fromPriceLabel.trailingAnchor
            $0.bottom == contentView.bottomAnchor - 14.0
        }
    }
}
