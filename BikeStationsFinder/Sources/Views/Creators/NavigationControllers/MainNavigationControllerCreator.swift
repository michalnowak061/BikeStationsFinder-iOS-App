import UIKit

class MainNavigationControllerCreator: NavigationControllerCreator {
  func create() -> UINavigationController {
    let navigationController = UINavigationController()
    navigationController.modalPresentationStyle = .fullScreen
    navigationController.modalTransitionStyle = .crossDissolve
    navigationController.navigationBar.barStyle = .black
    navigationController.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    navigationController.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    navigationController.navigationBar.isTranslucent = false
    navigationController.setNavigationBarHidden(true, animated: false)

    return navigationController
  }
}
