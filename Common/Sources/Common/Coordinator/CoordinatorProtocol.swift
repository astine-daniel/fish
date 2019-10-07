public protocol CoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorProtocol] { get }

    func start()
}
