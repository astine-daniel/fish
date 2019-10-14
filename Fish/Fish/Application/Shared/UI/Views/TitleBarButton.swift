import UIKit

final class TitleBarButton: UIControl {
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)
        label.textColor = .white

        return label
    }()

    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.Common.arrowDown.image

        return imageView
    }()

    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }

    // MARK: - Initialization
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Strings.Error.Fatal.notImplemented("init(coder:)"))
    }

    // MARK: - Overridden methods
    override var backgroundColor: UIColor? {
        didSet {
            titleLabel.backgroundColor = backgroundColor
            arrowImageView.backgroundColor = backgroundColor
        }
    }
}

private extension TitleBarButton {
    // MARK: - Setup
    func setup() {
        setupSubviews()
        setupConstraints()
    }

    func setupSubviews() {
        addSubview(titleLabel)
        addSubview(arrowImageView)
    }

    func setupConstraints() {
        setupTitleLabelConstraints()
        setupArrowImageViewConstraints()
    }

    // MARK: - Constraints
    func setupTitleLabelConstraints() {
        titleLabel.layout {
            $0.top == topAnchor
            $0.bottom == bottomAnchor
            $0.leading == leadingAnchor
        }
    }

    func setupArrowImageViewConstraints() {
        arrowImageView.layout {
            $0.width == 14.0
            $0.height == 14.0
            $0.leading == titleLabel.trailingAnchor + 2.0
            $0.trailing == trailingAnchor
            $0.bottom == titleLabel.bottomAnchor - 4.0
        }
    }
}
