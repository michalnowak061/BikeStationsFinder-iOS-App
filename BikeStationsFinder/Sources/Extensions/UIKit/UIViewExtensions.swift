import UIKit

extension UIView {
  func makeCircle() {
    self.layer.cornerRadius = self.frame.size.width / 2
    self.clipsToBounds = true
  }

  func addShadow() {
    self.layer.masksToBounds = false
    self.layer.shadowOffset = CGSize(width: 1, height: 1)
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowRadius = 10
    self.layer.shadowOpacity = 0.2
  }
}
