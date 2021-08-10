import UIKit

protocol ImplementingPopOverView {
  var popOverView: UIView { get }

  var animationDuration: TimeInterval { get }

  var heigth: CGFloat { get }

  func setupPopOverView()

  func showPopOverView()

  func hidePopOverView()
}

extension ImplementingPopOverView where Self: UIViewController {
  func setupPopOverView() {
    self.popOverView.alpha = 0
    self.popOverView.backgroundColor = .white

    // constraints
    self.view.addSubview(self.popOverView)
    self.popOverView.snp.makeConstraints { make in
      make.width.equalToSuperview()
      make.height.equalTo(self.heigth)
      make.top.equalTo(self.view.snp.bottom)
    }
  }

  func showPopOverView() {
    UIView.animate(withDuration: self.animationDuration) {
      let translationValue = self.heigth
      self.popOverView.transform = CGAffineTransform.init(translationX: 0, y: -translationValue)
    }
    UIView.animate(withDuration: self.animationDuration / 3) {
      self.popOverView.alpha = 1
    }
  }

  func hidePopOverView() {
    UIView.animate(withDuration: self.animationDuration) {
      let translationValue = self.heigth
      self.popOverView.transform = CGAffineTransform.init(translationX: 0, y: translationValue)
    }
    UIView.animate(withDuration: self.animationDuration / 3) {
      self.popOverView.alpha = 0
    }
  }
}
