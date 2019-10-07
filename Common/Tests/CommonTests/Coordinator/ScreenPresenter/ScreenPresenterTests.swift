import Common

import XCTest

final class ScreenPresenterTests: XCTestCase {
    // MARK: - Properties
    private var sut: ScreenPresenter!
    private var screenMock: MockScreen!

    // MARK: - Before each
    override func setUp() {
        super.setUp()

        screenMock = MockScreen()
        sut = ScreenPresenter(rootScreen: screenMock)
    }

    // MARK: - Tests
    func test_should_have_a_root_screen() {
        XCTAssert(sut.rootScreen === screenMock)
    }

    func test_should_set_module_as_root() throws {
        let module = MockPresentable()
    
        sut.setRoot(module, animated: true)

        let (presentedScreen, presentedStyle) = try XCTUnwrap(screenMock.screenPresentedWithStyle)

        XCTAssert(presentedScreen === module.screen)
        XCTAssertEqual(presentedStyle, .main(animated: true))
    }

    func test_should_present_module() throws {
        let module = MockPresentable()

        sut.present(module, animated: true)

        let (presentedScreen, presentedStyle) = try XCTUnwrap(screenMock.screenPresentedWithStyle)

        XCTAssert(presentedScreen === module.screen)
        XCTAssertEqual(presentedStyle, .modal(animated: true))
    }

    func test_should_dismiss_module() throws {
        let module = MockPresentable()

        sut.dismiss(module, animated: true)

        let didDismissModuleAnimated = try XCTUnwrap(screenMock.didDismissAnimated)
        XCTAssertEqual(didDismissModuleAnimated, true)
    }
}

// MARK: - Mocks
private final class MockScreen: ScreenProtocol {
    var screenPresentedWithStyle: (screen: ScreenProtocol, style: ScreenPresentStyle)?
    var didDismissAnimated: Bool?

    func present(_ screen: ScreenProtocol, style: ScreenPresentStyle) {
        screenPresentedWithStyle = (screen, style)
    }

    func dismiss(animated: Bool) {
        didDismissAnimated = animated
    }
}

private final class MockPresentable: Presentable {
    let screen: ScreenProtocol = MockScreen()

    func toPresent() -> ScreenProtocol {
        screen
    }
}
