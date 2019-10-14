open class Coordinator {
    // MARK: - Properties
    public private(set) final var childCoordinators: [CoordinatorProtocol] = []

    // MARK: - Initialization
    public init() { }

    // MARK: - Methods
    open func start() {
        guard type(of: self) != Coordinator.self else {
            fatalError("Method must be overridden")
        }
    }
}

// MARK: - CoordinatorProtocol extension
extension Coordinator: CoordinatorProtocol { }

// MARK: - Child manager methods
public extension Coordinator {
    final func add(child coordinator: CoordinatorProtocol) {
        guard childCoordinators.first(where: { $0 === coordinator }) == nil else { return }
        childCoordinators.append(coordinator)
    }

    final func remove(child coordinator: CoordinatorProtocol) {
        childCoordinators.removeAll(where: { $0 === coordinator })
    }

    final func removeAllChildCoordinator() {
        childCoordinators.removeAll(keepingCapacity: true)
    }
}
