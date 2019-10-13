import Common
import UIKit

final class InTheCityCoordinator: Coordinator {
    // MARK: - Properties
    private let navigationPresenter: NavigationPresenterProtocol
    private var started: Bool = false

    // MARK: - Initialization
    init(navigationPresenter: NavigationPresenterProtocol) {
        self.navigationPresenter = navigationPresenter

        super.init()
    }

    // MARK: - Methods
    override func start() {
        guard started == false else { return }
        started.toggle()

        let controller = UIViewController(nibName: nil, bundle: nil)
        controller.view.backgroundColor = .white

        navigationPresenter.setRoot(controller, animated: false)
    }
}

// MARK: - InTheCityCoordinatorProtocol extension
extension InTheCityCoordinator: InTheCityCoordinatorProtocol {
    func toPresent() -> ScreenProtocol { navigationPresenter.rootScreen }
}
