import Common

import XCTest

final class CoordinatorTests: XCTestCase {
    // MARK: - Properties
    private var coordinator: Coordinator!

    // MARK: - Before each
    override func setUp() {
        super.setUp()

        coordinator = Coordinator()
    }

    // MARK: - Tests
    func test_shouldnt_start_when_not_a_subclass() {
        expectFatalError(expectedMessage: "Method must be overridden") {
            self.coordinator.start()
        }
    }

    func test_should_start_when_a_subclass() {
        let coordinator = FakeCoordinator()
        coordinator.start()
    }

    func test_should_add_coordinator_as_child() {
        let previousNumberOfChildren = coordinator.childCoordinators.count

        let child = FakeCoordinator()
        coordinator.add(child: child)

        XCTAssertEqual(coordinator.childCoordinators.count, previousNumberOfChildren + 1)
        XCTAssert(coordinator.childCoordinators.contains(where: { $0 === child }))
    }

    func test_shouldnt_add_same_coordinator_as_child() {
        let previousNumberOfChildren = coordinator.childCoordinators.count

        let child = FakeCoordinator()
        coordinator.add(child: child)
        coordinator.add(child: child)

        XCTAssertEqual(coordinator.childCoordinators.count, previousNumberOfChildren + 1)
    }

    func test_should_remove_coordinator_from_parent() {
        let previousNumberOfChildren = coordinator.childCoordinators.count

        let child = FakeCoordinator()
        coordinator.add(child: child)
        coordinator.remove(child: child)

        XCTAssertEqual(coordinator.childCoordinators.count, previousNumberOfChildren)
    }

    func test_should_remove_all_child_coordinators() {
        coordinator.add(child: FakeCoordinator())
        coordinator.add(child: FakeCoordinator())

        coordinator.removeAllChildCoordinator()

        XCTAssertEqual(coordinator.childCoordinators.count, 0)
    }
}

// MARK: - Fake coordinator
private final class FakeCoordinator: Coordinator { }
