import UIKit

extension UIViewController {
  func showOkAlert(title: String, message: String, handler: @escaping (UIAlertAction) -> Void) {
    DispatchQueue.main.async {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
      self.present(alert, animated: true, completion: nil)
    }
  }
}
