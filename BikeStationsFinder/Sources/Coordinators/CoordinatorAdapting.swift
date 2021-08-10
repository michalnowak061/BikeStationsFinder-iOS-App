import UIKit

protocol CoordinatorAdapting: AnyObject {
  // MARK: - Variable's
  var navigationController: UINavigationController { get set }

  var childCoordinators: [CoordinatorAdapting] { get set }

  // MARK: - Function's
  func start()
}

// MARK: - Extension's
extension CoordinatorAdapting {
  func presentCoordinator(coordinator: CoordinatorAdapting) {
    coordinator.start()
    self.childCoordinators.append(coordinator)
    self.navigationController.present(coordinator.navigationController, animated: true)
  }
}
