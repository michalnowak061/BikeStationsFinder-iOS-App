import UIKit

class AvailableView: UIView {
  // MARK: - Private variable's
  var image: UIImage! {
    didSet {
      self.imageView.image = self.image
    }
  }

  var title: String! {
    didSet {
      self.titleLabel.text = self.title
    }
  }

  var countColor: UIColor! {
    didSet {
      self.countLabel.textColor = self.countColor
    }
  }

  var count: String! {
    didSet {
      self.countLabel.text = self.count
    }
  }

  private var imageView: UIImageView!

  private var titleLabel: UILabel!

  private var countLabel: UILabel!

  private var titleLabelFont: UIFont {
    UIFont(name: "Helvetica-Light", size: UIScreen.main.bounds.size.height * 0.02) ?? UIFont()
  }

  private var countLabelFont: UIFont {
    UIFont(name: "Helvetica-Bold", size: UIScreen.main.bounds.size.height * 0.08) ?? UIFont()
  }

  // MARK: - Private constant's
  private var spacing: CGFloat {
    UIScreen.main.bounds.size.width * 0.02
  }

  // MARK: - Function's
  init(frame: CGRect, image: UIImage, title: String, countColor: UIColor, count: String) {
    super.init(frame: frame)
    self.image = image
    self.title = title
    self.countColor = countColor
    self.count = count
    self.setup()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  private func setup() {
    self.setupImageView()
    self.setupTitleLabel()
    self.setupCountLabel()
  }

  private func setupImageView() {
    self.imageView = UIImageView()
    self.imageView.image = self.image
    self.imageView.contentMode = .scaleAspectFit

    // constraints
    self.addSubview(self.imageView)
    self.imageView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.left.equalToSuperview()
      make.width.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(0.2)
    }
  }

  private func setupTitleLabel() {
    self.titleLabel = TitleLabelCreator().create()
    self.titleLabel.font = self.titleLabelFont
    self.titleLabel.text = self.title

    // constraints
    self.addSubview(self.titleLabel)
    self.titleLabel.snp.makeConstraints { make in
      make.top.equalTo(self.imageView.snp.bottom).offset(self.spacing)
      make.left.equalToSuperview()
      make.width.equalToSuperview()
      make.height.equalToSuperview().multipliedBy(0.15)
    }
  }

  private func setupCountLabel() {
    self.countLabel = TitleLabelCreator().create()
    self.countLabel.font = self.countLabelFont
    self.countLabel.text = self.count
    self.countLabel.textColor = self.countColor

    // constraints
    self.addSubview(self.countLabel)
    self.countLabel.snp.makeConstraints { make in
      make.top.equalTo(self.titleLabel.snp.bottom).offset(self.spacing)
      make.left.equalToSuperview()
      make.width.equalToSuperview()
      make.bottom.equalToSuperview()
    }
  }
}
