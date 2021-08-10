import UIKit

class ListCoordinator: CoordinatorAdapting {
  // MARK: - Private constant's
  private let viewControllersBackgroundColor = #colorLiteral(red: 0.9357246112, green: 0.9357246112, blue: 0.9357246112, alpha: 1)

  // MARK: - Variable's
  var navigationController: UINavigationController

  var childCoordinators: [CoordinatorAdapting]

  var model: BikeStationsManagerAdapting

  // MARK: - Init
  required init(model: BikeStationsManagerAdapting, navigationController: UINavigationController) {
    self.model = model
    self.navigationController = navigationController
    self.childCoordinators = []
  }

  // MARK: - Function's
  func start() {
    let listViewController = ListViewController(model: self.model, coordinator: self)
    listViewController.view.backgroundColor = self.viewControllersBackgroundColor

    self.navigationController.setNavigationBarHidden(false, animated: true)
    self.navigationController.pushViewController(listViewController, animated: true)
  }

  func showMapViewController() {
    let mapViewController = MapViewController(model: self.model)
    mapViewController.view.backgroundColor = self.viewControllersBackgroundColor

    self.navigationController.pushViewController(mapViewController, animated: true)
  }
}
