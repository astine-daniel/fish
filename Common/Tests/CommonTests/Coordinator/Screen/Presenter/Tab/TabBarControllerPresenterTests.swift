import Common

import UIKit
import XCTest

final class TabBarControllerPresenterTests: XCTestCase {
    // MARK: - Properties
    private var sut: TabBarControllerPresenter!
    private var rootModule: MockScreen!
    private var tabScreen: MockTabScreen!

    // MARK: - Before each
    override func setUp() {
        super.setUp()

        rootModule = MockScreen()

        tabScreen = MockTabScreen()
        tabScreen.setViewControllers([rootModule], animated: false)

        sut = TabBarControllerPresenter(tabScreen: tabScreen)
    }

    // MARK: - Tests
    func test_should_have_a_root_screen() {
        XCTAssert(sut.rootScreen === tabScreen)
    }

    func test_should_set_root_module_of_tab_animated() {
        test_should_set_root_module_of_tab(module: UIViewController(), animated: true)

        XCTAssertTrue(tabScreen.didAnimatePresentation)
    }

    func test_should_set_root_module_of_tab_not_animated() {
        test_should_set_root_module_of_tab(module: UIViewController(), animated: false)

        XCTAssertFalse(tabScreen.didAnimatePresentation)
    }

    func test_should_present_module_animated() throws {
        try test_should_present_module(UIViewController(), animated: true)

        XCTAssertTrue(rootModule.didAnimatePresentation)
    }

    func test_should_present_module_not_animated() throws {
        try test_should_present_module(UIViewController(), animated: false)

        XCTAssertFalse(rootModule.didAnimatePresentation)
    }

    func test_should_dismiss_module_animated() {
        test_should_dismiss_module(UIViewController(), animated: true)
        XCTAssertTrue(tabScreen.didAnimatePresentation)
    }

    func test_should_dismiss_module_not_animated() {
        test_should_dismiss_module(UIViewController(), animated: false)
        XCTAssertFalse(tabScreen.didAnimatePresentation)
    }

    func test_should_show_tabs_aniamted() {
        let tabs = [UIViewController(), UIViewController(), UIViewController()]
        let items = (0 ..< 3).map {
            TabItem<UIImage>(title: "Module #\($0)", icon: nil, selectedIcon: nil)
        }

        test_should_show_tabs(tabs, items: items, animated: true)
        XCTAssertTrue(tabScreen.didAnimatePresentation)
    }

    func test_should_show_tabs_not_aniamted() {
        let tabs = [UIViewController(), UIViewController(), UIViewController()]
        let items = (0 ..< 3).map {
            TabItem<UIImage>(title: "Module #\($0)", icon: nil, selectedIcon: nil)
        }

        test_should_show_tabs(tabs, items: items, animated: false)
        XCTAssertFalse(tabScreen.didAnimatePresentation)
    }

    func test_should_ask_if_can_show_module() throws {
        var indexThatWillBeSelected = -1

        sut.shoulSelectTabAtIndex = { index in
            indexThatWillBeSelected = index
            return false
        }

        let controllerWillBeSelectd = UIViewController()
        let tabs = [UIViewController(), UIViewController(), controllerWillBeSelectd]
        let items = (0 ..< 3).map {
            TabItem<UIImage>(title: "Module #\($0)", icon: nil, selectedIcon: nil)
        }

        sut.show(tabs: tabs, items: items, animated: false)

        let shouldSelect = try XCTUnwrap(
            tabScreen.delegate?.tabBarController?(tabScreen, shouldSelect: controllerWillBeSelectd)
        )

        XCTAssertEqual(indexThatWillBeSelected, 2)
        XCTAssertFalse(shouldSelect)
    }

    func test_should_notify_that_tab_was_selected() {
        var selectedIndex = -1

        sut.didSelectTabAtIndex = { index in
            selectedIndex = index
        }

        let selectedController = UIViewController()
        let tabs = [UIViewController(), selectedController, UIViewController()]
        let items = (0 ..< 3).map {
            TabItem<UIImage>(title: "Module #\($0)", icon: nil, selectedIcon: nil)
        }

        sut.show(tabs: tabs, items: items, animated: false)

        tabScreen.delegate?.tabBarController?(tabScreen, didSelect: selectedController)

        XCTAssertEqual(selectedIndex, 1)
    }
}

// MARK: - Private extension
private extension TabBarControllerPresenterTests {
    func test_should_set_root_module_of_tab(module: UIViewController, animated: Bool) {
        sut.setRoot(module, animated: animated)

        XCTAssertTrue(tabScreen.didShowModules)
        XCTAssertEqual(tabScreen.tabs, [module])
    }

    func test_should_present_module(_ module: UIViewController, animated: Bool) throws {
        sut.present(module, animated: animated)

        XCTAssertEqual(try XCTUnwrap(rootModule.presentedModule), module)
    }

    func test_should_dismiss_module(_ module: UIViewController, animated: Bool) {
        sut.dismiss(module, animated: animated)

        XCTAssertTrue(tabScreen.didDismissModule)
    }

    func test_should_show_tabs(_ tabs: [UIViewController], items: [TabItem<UIImage>], animated: Bool) {
        sut.show(tabs: tabs, items: items, animated: animated)

        XCTAssertTrue(tabScreen.didShowModules)
        XCTAssertEqual(tabScreen.tabs, tabs)
        assertEquals(tabScreen.tabs.map({ $0.tabBarItem }), to: items)
    }

    func assertEquals(_ tabItems: [UITabBarItem], to items: [TabItem<UIImage>]) {
        zip(tabItems, items).forEach {
            let (tabItem, item) = $0

            XCTAssertEqual(tabItem.title, item.title)
            XCTAssertEqual(tabItem.image, item.icon)
            XCTAssertEqual(tabItem.selectedImage, item.selectedIcon)
        }
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

private final class MockTabScreen: UITabBarController {
    // MARK: - Properties
    var didAnimatePresentation: Bool = false
    var rootModule: UIViewController?

    var didDismissModule: Bool = false

    var didShowModules: Bool = false
    var tabs: [UIViewController] = []

    override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: false)

        didShowModules = true
        didAnimatePresentation = animated
        tabs = viewControllers ?? []
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)

        didDismissModule = true
        didAnimatePresentation = flag
    }
}
