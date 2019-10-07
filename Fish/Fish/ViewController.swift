import UIKit

final class ViewController: UIViewController {
    // MARK: - Initialization
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View lifecycle
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
}
