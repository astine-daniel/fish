public protocol ScreenProtocol: AnyObject {
    func present(_ screen: ScreenProtocol, style: ScreenPresentStyle)
    func dismiss(animated: Bool)
}
