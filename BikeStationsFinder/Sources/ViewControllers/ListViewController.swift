import UIKit

class ListViewController: UIViewController {
  // MARK: - Override's
  init(model: BikeStationsManagerAdapting, coordinator: CoordinatorAdapting?) {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
}
