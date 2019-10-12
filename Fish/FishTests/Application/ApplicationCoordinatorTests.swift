import Common
@testable import Fish

import XCTest

final class ApplicationCoordinatorTests: XCTestCase {
    // MARK: - Properties
    private var sut: ApplicationCoordinator!

    private var screenPresenter: FakeScreenPresenter!
    private var factory: FakeFactory!

    // MARK: - Before each
    override func setUp() {
        super.setUp()

        screenPresenter = FakeScreenPresenter()
        factory = FakeFactory()

        sut = ApplicationCoordinator(
            screenPresenter: screenPresenter,
            coordinatorFactory: factory)
    }

    // MARK: - Tests
    func test_when_start_should_run_home_flow() throws {
        sut.start()

        XCTAssertTrue(screenPresenter.didSetRoot)

        let presentedModule = try XCTUnwrap(screenPresenter.presentedModule)
        XCTAssertTrue(presentedModule === factory.homeCoordinator)

        XCTAssertTrue(factory.didMakeHomeCoordinator)
    }
}

// MARK: - Fake coordinator
private final class FakeScreenPresenter: ScreenPresenterProtocol {
    // MARK: - Properties
    private (set) var rootScreen: ScreenProtocol

    var didSetRoot: Bool = false
    var presentedModule: Module?

    // MARK: - Initialization
    init() {
        rootScreen = UIWindow()
    }

    func setRoot(_ module: Module, animated: Bool) {
        presentedModule = module
        didSetRoot = true
    }

    func present(_ module: Module, animated: Bool) {
        didSetRoot = false
    }

    func dismiss(_ module: Module, animated: Bool) {
        didSetRoot = false
    }
}

private final class FakeHomeCoordinator: Coordinator, HomeCoordinatorProtocol {
    func toPresent() -> ScreenProtocol { return UIViewController() }
}

private final class FakeFactory: ApplicationCoordinator.CoordinatorFactory {
    // MARK: - Properties
    let homeCoordinator = FakeHomeCoordinator()

    var didMakeHomeCoordinator: Bool = false

    // MARK: - Methods
    func makeHomeCoordinator() -> HomeCoordinatorProtocol {
        didMakeHomeCoordinator = true
        return homeCoordinator
    }
}
