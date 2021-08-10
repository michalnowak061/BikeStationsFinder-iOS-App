import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  var appCoordinator: CoordinatorAdapting?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    let window = UIWindow(frame: UIScreen.main.bounds)
    let navigationController = MainNavigationControllerCreator().create()

    self.appCoordinator = AppCoordinator(navigationController: navigationController)
    self.appCoordinator?.start()

    window.rootViewController = self.appCoordinator?.navigationController
    window.makeKeyAndVisible()
    self.window = window

    return true
  }
}
