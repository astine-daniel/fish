import Common
import UIKit

@available(iOS 13.0, *)
final class SceneDelegate: UIResponder {
    // MARK: - Properties
    private lazy var applicationCoordinator = ApplicationCoordinator(
        screenPresenter: ScreenPresenter(rootScreen: window!),
        coordinatorFactory: CoordinatorFactory())

    var window: UIWindow?
}

// MARK: - UIWindowSceneDelegate extension
@available(iOS 13.0, *)
extension SceneDelegate: UIWindowSceneDelegate {
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }

        window = UIWindow(windowScene: scene)

        applicationCoordinator.start()
        window?.makeKeyAndVisible()
    }
}
