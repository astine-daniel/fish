import Common
import UIKit

final class ApplicationCoordinator: Coordinator {
    typealias CoordinatorFactory = HomeCoordinatorFactoryProtocol

    // MARK: - Properties
    private let screenPresenter: ScreenPresenterProtocol
    private let coordinatorFactory: CoordinatorFactory

    // MARK: - Initialization
    init(screenPresenter: ScreenPresenterProtocol,
         coordinatorFactory: CoordinatorFactory) {
        self.screenPresenter = screenPresenter
        self.coordinatorFactory = coordinatorFactory
    }

    // MARK: - Methods
    override func start() {
        let module = coordinatorFactory.makeHomeCoordinator()
        add(child: module)

        module.start()

        screenPresenter.setRoot(module, animated: false)
    }
}
