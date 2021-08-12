import UIKit

class BikeStationCollectionViewCell: UICollectionViewCell {
  // MARK: - Static constant's
  static let identifier = "BikeStationCVC"

  // MARK: - Variable's
  var subview: UIView? {
    willSet {
      self.subview?.removeFromSuperview()
      self.subview = nil
    }
    didSet {
      self.setupSubview()
    }
  }

  // MARK: - Override's
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    self.addShadow()
  }

  // MARK: - Private function's
  private func setupSubview() {
    guard let subview = self.subview else {
      return
    }

    subview.clipsToBounds = true
    subview.layer.cornerRadius = 10

    // constraints
    self.contentView.addSubview(subview)
    subview.snp.makeConstraints { make in
      make.width.height.equalToSuperview()
      make.center.equalToSuperview()
    }
  }
}
