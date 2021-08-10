import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  var appCoordinator: CoordinatorAdapting?

  @available(iOS 13.0, *)
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else {
      return
    }

    let window = UIWindow(windowScene: windowScene)
    let navigationController = MainNavigationControllerCreator().create()

    self.appCoordinator = AppCoordinator(navigationController: navigationController)
    self.appCoordinator?.start()

    window.rootViewController = self.appCoordinator?.navigationController
    window.makeKeyAndVisible()
    self.window = window
  }
}
