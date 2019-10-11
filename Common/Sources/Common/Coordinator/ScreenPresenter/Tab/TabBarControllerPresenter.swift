#if canImport(UIKit)

import UIKit

public final class TabBarControllerPresenter {
    public typealias TabScreen = UITabBarController & ScreenProtocol

    // MARK: - Properties
    private (set) var tabScreen: TabScreen

    // MARK: - Initialization
    public required init(tabScreen: TabScreen) {
        self.tabScreen = tabScreen
    }
}

// MARK: - TabPresenterProtocol extension
extension TabBarControllerPresenter: TabPresenterProtocol {
    public var rootScreen: ScreenProtocol { tabScreen }

    public func setRoot(_ module: Module, animated: Bool) {
        let module = module.toPresent()
        tabScreen.present(module, style: .main(animated: animated))
    }

    public func present(_ module: Module, animated: Bool) {
        let module = module.toPresent()
        tabScreen.present(module, style: .modal(animated: animated))
    }

    public func dismiss(_ module: Module, animated: Bool) {
        tabScreen.dismiss(animated: animated)
    }

    public func show<T>(tabs modules: [Module], items: [TabItem<T>], animated: Bool) {
        let modules = modules.compactMap({ $0.toPresent() as? UIViewController })
        guard let items = items as? [TabItem<UIImage>], modules.count == items.count else { return }

        show(modules: modules, items: items, animated: animated)
    }
}

// MARK: - Private extension
private extension TabBarControllerPresenter {
    func show(modules: [UIViewController], items: [TabItem<UIImage>], animated: Bool) {
        let modules = zip(modules, items).map { elements -> UIViewController in
            let (module, item) = elements
            module.tabBarItem = tabBarItem(from: item)

            return module
        }

        tabScreen.setViewControllers(modules, animated: animated)
    }

    func tabBarItem(from item: TabItem<UIImage>) -> UITabBarItem {
        UITabBarItem(title: item.title, image: item.icon, selectedImage: item.selectedIcon)
    }
}

#endif
