import UIKit

class AppCoordinator: CoordinatorAdapting {
  // MARK: - Private constant's
  private let viewControllersBackgroundColor = #colorLiteral(red: 0.9357246112, green: 0.9357246112, blue: 0.9357246112, alpha: 1)

  // MARK: - Variable's
  var navigationController: UINavigationController

  var childCoordinators: [CoordinatorAdapting]

  // MARK: - Init
  required init(navigationController: UINavigationController) {
    self.navigationController = navigationController
    self.childCoordinators = []
  }

  // MARK: - Function's
  func start() {
    let loadingViewController = LoadingViewController(coordinator: self)
    loadingViewController.view.backgroundColor = self.viewControllersBackgroundColor

    self.navigationController.pushViewController(loadingViewController, animated: true)
  }

  func showListCoordinator(model: BikeStationsManagerAdapting) {
    let navigationController = MainNavigationControllerCreator().create()
    let listCoordinator = ListCoordinator(model: model, navigationController: navigationController)
    self.presentCoordinator(coordinator: listCoordinator)
  }
}
