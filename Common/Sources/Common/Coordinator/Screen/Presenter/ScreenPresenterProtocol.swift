public protocol ScreenPresenterProtocol {
    typealias Module = Presentable

    var rootScreen: ScreenProtocol { get }

    func setRoot(_ module: Module, animated: Bool)
    func present(_ module: Module, animated: Bool)
    func dismiss(_ module: Module, animated: Bool)
}
