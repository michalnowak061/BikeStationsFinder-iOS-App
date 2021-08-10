import MapKit
import UIKit

class BikeStationAnnotationView: MKAnnotationView {
  // MARK: - Private variable's
  private var contentView: UIView!

  private var viewForImage: UIView!

  private var imageView: UIImageView!

  private var label: UILabel!

  private var size: CGSize {
    CGSize(
      width: UIScreen.main.bounds.size.width * 0.3,
      height: UIScreen.main.bounds.size.width * 0.15)
  }

  private var labelFont: UIFont {
    UIFont(name: "Helvetica-Bold", size: UIScreen.main.bounds.size.height * 0.05) ?? UIFont()
  }

  // MARK: - Variable's
  var icon: UIImage? {
    willSet {
      self.imageView.image = newValue
    }
  }

  var count: String? {
    willSet {
      self.label.text = newValue
    }
  }

  var color: UIColor? {
    willSet {
      self.label.textColor = newValue
    }
  }

  // MAR: - Override's
  override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
    super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    self.setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func draw(_ rect: CGRect) {
    super.draw(rect)
    self.viewForImage.makeCircle()
    self.viewForImage.addShadow()
  }

  // MARK: - Private function's
  private func setup() {
    self.frame = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)

    self.setupContentView()
    self.setupViewForImage()
    self.setupImageView()
    self.setupLabel()
  }

  private func setupContentView() {
    self.contentView = UIView()

    // constraints
    self.addSubview(self.contentView)
    self.contentView.frame = bounds
  }

  private func setupViewForImage() {
    self.viewForImage = UIView()
    self.viewForImage.backgroundColor = .white

    // constraints
    self.contentView.addSubview(self.viewForImage)
    self.viewForImage.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.left.equalToSuperview()
      make.width.equalTo(self.contentView.snp.height)
      make.bottom.equalToSuperview()
    }
  }

  private func setupImageView() {
    self.imageView = UIImageView()
    self.imageView.contentMode = .scaleAspectFit

    // constraints
    self.viewForImage.addSubview(self.imageView)
    self.imageView.snp.makeConstraints { make in
      make.height.equalToSuperview().multipliedBy(0.6)
      make.width.equalToSuperview().multipliedBy(0.6)
      make.center.equalToSuperview()
    }
  }

  private func setupLabel() {
    self.label = TitleLabelCreator().create()
    self.label.font = self.labelFont

    // constraints
    self.contentView.addSubview(self.label)
    self.label.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.right.equalToSuperview()
      make.left.equalTo(self.imageView.snp.right)
      make.bottom.equalToSuperview()
    }
  }
}
