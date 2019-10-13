public final class ScreenPresenter {
    // MARK: - Properties
    public private(set) var rootScreen: ScreenProtocol

    // MARK: - Initialization
    public init(rootScreen: ScreenProtocol) {
        self.rootScreen = rootScreen
    }
}

// MARK: - ScreenPresenterProtocol extension
extension ScreenPresenter: ScreenPresenterProtocol {
    public func setRoot(_ module: Module, animated: Bool) {
        let screen = module.toPresent()
        rootScreen.present(screen, style: .main(animated: animated))
    }

    public func present(_ module: Module, animated: Bool) {
        let screen = module.toPresent()
        rootScreen.present(screen, style: .modal(animated: animated))
    }

    public func dismiss(_ module: Module, animated: Bool) {
        rootScreen.dismiss(animated: animated)
    }
}
