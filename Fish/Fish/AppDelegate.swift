import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder {
    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
}

// MARK: - UIApplicationDelegate extension
extension AppDelegate: UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13, *) {
        } else {
            legacyStart()
        }

        return true
    }

    // MARK: - UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

// MARK: - Private extension
private extension AppDelegate {
    @available(iOS, obsoleted: 13)
    func legacyStart() {
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
    }
}
