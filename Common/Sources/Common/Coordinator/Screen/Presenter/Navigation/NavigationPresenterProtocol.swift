public protocol NavigationPresenterProtocol: ScreenPresenterProtocol {
    typealias Completion = () -> Void

    func show(_ module: Module, animated: Bool, completionWhenPopped: Completion?)
    func backToRootModule(animatedWith animation: NavigationPresenterBackAnimation, completion: Completion?)
    func backTo(_ module: Module, animatedWith animation: NavigationPresenterBackAnimation, completion: Completion?)
}
