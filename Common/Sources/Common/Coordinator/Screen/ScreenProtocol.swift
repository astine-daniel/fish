public protocol ScreenProtocol: Presentable {
    func present(_ screen: ScreenProtocol, style: ScreenPresentStyle)
    func dismiss(animated: Bool)
}

public extension ScreenProtocol {
    func toPresent() -> ScreenProtocol { self }
}
