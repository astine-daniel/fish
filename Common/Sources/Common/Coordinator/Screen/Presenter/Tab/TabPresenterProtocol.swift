public struct TabItem<Icon> {
    // MARK: - Properties
    public let title: String
    public let icon: Icon?
    public let selectedIcon: Icon?

    // MARK: - Initialization
    public init(title: String, icon: Icon?, selectedIcon: Icon?) {
        self.title = title
        self.icon = icon
        self.selectedIcon = selectedIcon
    }
}

public protocol TabPresenterProtocol: ScreenPresenterProtocol {
    typealias Completion = () -> Void

    var shoulSelectTabAtIndex: ((Int) -> Bool)? { get set }
    var didSelectTabAtIndex: ((Int) -> Void)? { get set }

    func show<T>(tabs modules: [Module], items: [TabItem<T>], animated: Bool)
}
