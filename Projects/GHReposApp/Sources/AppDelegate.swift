import UIKit
import Routers

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var router: RouterType?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        let navigationController = UINavigationController()
        
        router = RepoListRouter(
            navigationController: navigationController
        )

        router?.setUp()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
