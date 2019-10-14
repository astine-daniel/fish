import Common

import UIKit
import XCTest

final class NavigationControllerPresenterTests: XCTestCase {
    // MARK: - Properties
    private var sut: NavigationControllerPresenter!
    private var rootScreen: MockScreen!
    private var navigationScreen: MockNavigationScreen!

    // MARK: - Before each
    override func setUp() {
        super.setUp()

        rootScreen = MockScreen()
        navigationScreen = MockNavigationScreen(rootViewController: rootScreen)

        sut = NavigationControllerPresenter(navigationScreen: navigationScreen)
    }

    // MARK: - Tests
    func test_should_have_a_root_screen() {
        XCTAssert(sut.rootScreen === navigationScreen)
    }

    func test_should_set_root_screen_of_navigation_animated() throws {
        try test_should_set_root_screen_of_navigation(module: UIViewController(), animated: true)

        XCTAssertTrue(navigationScreen.didAnimatePresentation)
    }

    func test_should_set_root_screen_of_navigation_not_animated() throws {
        try test_should_set_root_screen_of_navigation(module: UIViewController(), animated: false)

        XCTAssertFalse(navigationScreen.didAnimatePresentation)
    }

    func test_should_present_module_animated() throws {
        try test_should_present_module(UIViewController(), animated: true)

        XCTAssertTrue(rootScreen.didAnimatePresentation)
    }

    func test_should_present_module_not_animated() throws {
        try test_should_present_module(UIViewController(), animated: false)

        XCTAssertFalse(rootScreen.didAnimatePresentation)
    }

    func test_should_dismiss_module_animated() {
        sut.dismiss(UIViewController(), animated: true)

        XCTAssertTrue(navigationScreen.didDismissModule)
        XCTAssertTrue(navigationScreen.didAnimatePresentation)
    }

    func test_should_dismiss_module_not_animated() {
        sut.dismiss(UIViewController(), animated: false)

        XCTAssertTrue(navigationScreen.didDismissModule)
        XCTAssertFalse(navigationScreen.didAnimatePresentation)
    }

    func test_should_show_module_in_navigation_animated() throws {
        try test_should_show_module_in_navigation(module: UIViewController(), animated: true)

        XCTAssertTrue(navigationScreen.didAnimatePresentation)
    }

    func test_should_show_module_in_navigation_not_animated() throws {
        try test_should_show_module_in_navigation(module: UIViewController(), animated: false)

        XCTAssertFalse(navigationScreen.didAnimatePresentation)
    }

    func test_should_calls_callback_when_back_to_module() {
        let firstModule = UIViewController()
        let secondModule = UIViewController()

        let secondModuleExpectation = self.expectation(description: "call callback of second module when pop")
        let completePopExpectation = self.expectation(description: "call complete callback when finish pop")

        sut.show(firstModule, animated: false, completionWhenPopped: nil)

        sut.show(secondModule, animated: false) {
            secondModuleExpectation.fulfill()
        }

        sut.backTo(firstModule, animatedWith: .none) {
            completePopExpectation.fulfill()
        }

        wait(for: [secondModuleExpectation, completePopExpectation], timeout: 5.0)
    }

    func test_should_calls_callback_when_back_to_root() {
        let firstModule = UIViewController()
        let secondModule = UIViewController()

        let firstModuleExpectation = self.expectation(description: "call callback of first module when pop")
        let secondModuleExpectation = self.expectation(description: "call callback of second module when pop")
        let completePopExpectation = self.expectation(description: "call complete callback when finish pop")

        sut.show(firstModule, animated: false) {
            firstModuleExpectation.fulfill()
        }

        sut.show(secondModule, animated: false) {
            secondModuleExpectation.fulfill()
        }

        sut.backToRootModule(animatedWith: .none) {
            completePopExpectation.fulfill()
        }

        wait(for: [firstModuleExpectation, secondModuleExpectation, completePopExpectation], timeout: 5.0)
    }
}

// MARK: - Private extension
private extension NavigationControllerPresenterTests {
    func test_should_set_root_screen_of_navigation(module: UIViewController, animated: Bool) throws {
        sut.setRoot(module, animated: animated)

        XCTAssertTrue(navigationScreen.didSetRootModule)
        XCTAssertEqual(try XCTUnwrap(navigationScreen.rootModule), module)
    }

    func test_should_present_module(_ module: UIViewController, animated: Bool) throws {
        sut.present(module, animated: animated)

        XCTAssertEqual(try XCTUnwrap(rootScreen.presentedModule), module)
    }

    func test_should_show_module_in_navigation(module: UIViewController, animated: Bool) throws {
        sut.show(module, animated: animated, completionWhenPopped: nil)

        XCTAssertTrue(navigationScreen.didShowModule)
        XCTAssertEqual(try XCTUnwrap(navigationScreen.visibleModule), module)
    }
}

// MARK: - Mocks
private final class MockScreen: UIViewController {
    var didAnimatePresentation: Bool = false
    var presentedModule: UIViewController?

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        didAnimatePresentation = flag
        presentedModule = viewControllerToPresent
    }
}

private final class MockNavigationScreen: UINavigationController {
    // MARK: - Properties
    var didSetRootModule: Bool = false
    var didAnimatePresentation: Bool = false
    var rootModule: UIViewController?

    var didDismissModule: Bool = false

    var didShowModule: Bool = false
    var visibleModule: UIViewController?

    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)

        didSetRootModule = true
        didAnimatePresentation = animated

        rootModule = viewControllers.first
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)

        didDismissModule = true
        didAnimatePresentation = flag
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)

        didShowModule = true
        didAnimatePresentation = animated
        visibleModule = viewController
    }

    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        guard let index = viewControllers.firstIndex(of: viewController),
            viewControllers.count > index + 1 else {
                return nil
        }

        DispatchQueue.main.async {
            self.delegate?.navigationController?(self, didShow: viewController, animated: animated)
        }

        return Array(viewControllers[(index + 1) ..< viewControllers.count])
    }
}
