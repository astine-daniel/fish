import UIKit

@available(iOS 13.0, *)
final class SceneDelegate: UIResponder {
    // MARK: - Properties
    var window: UIWindow?
}

// MARK: - UIWindowSceneDelegate extension
@available(iOS 13.0, *)
extension SceneDelegate: UIWindowSceneDelegate {
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }

        window = UIWindow(windowScene: scene)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
    }
}
