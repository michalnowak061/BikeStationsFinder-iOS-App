import UIKit

class BikeStationInfoView: UIView {
  // MARK: - Private constant's
  private var spacing: CGFloat {
    UIScreen.main.bounds.size.width * 0.05
  }

  // MARK: - Private variable's
  private var titleLabel: UILabel!

  private var adressLabel: UILabel!

  private var availableBikesView: AvailableView!

  private var availablePlacesView: AvailableView!

  private var adressDistanceFont: UIFont {
    UIFont(name: "Helvetica-Bold", size: UIScreen.main.bounds.size.height * 0.025) ?? UIFont()
  }

  private var adressLocalizationFont: UIFont {
    UIFont(name: "Helvetica-Light", size: UIScreen.main.bounds.size.height * 0.025) ?? UIFont()
  }

  private var titleLabelFont: UIFont {
    UIFont(name: "Helvetica-Bold", size: UIScreen.main.bounds.size.height * 0.04) ?? UIFont()
  }

  var station: BikeStation! {
    didSet {
      self.update(station: self.station)
    }
  }

  private var adressString: NSMutableAttributedString {
    let distanceStringAttributes: [NSAttributedString.Key: Any] = [
      NSAttributedString.Key.font: self.adressDistanceFont as Any,
      NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2462273836, green: 0.2462682128, blue: 0.2462184131, alpha: 1)
    ]

    let adressStringAttributes: [NSAttributedString.Key: Any] = [
      NSAttributedString.Key.font: self.adressLocalizationFont as Any,
      NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4036181867, green: 0.403680414, blue: 0.4036045671, alpha: 1)
    ]

    let distanceString = NSMutableAttributedString(
      string: self.station.distanceString ?? "",
      attributes: distanceStringAttributes)

    let adressString = NSMutableAttributedString(
      string: (self.station.adress != nil ? " ⋅ " + (self.station.adress ?? "") : ""),
      attributes: adressStringAttributes)

    distanceString.append(adressString)
    return distanceString
  }

  // MARK: - Function's
  init(frame: CGRect, station: BikeStation) {
    super.init(frame: frame)
    self.station = station
    self.setup()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  // MARK: - Private function's
  private func setup() {
    self.backgroundColor = #colorLiteral(red: 0.9999127984, green: 1, blue: 0.9998814464, alpha: 1)

    self.setupTitleLabel()
    self.setupAdressLabel()
    self.setupAvailableBikesView()
    self.setupAvailablePlacesView()
  }

  private func setupTitleLabel() {
    self.titleLabel = TitleLabelCreator().create()
    self.titleLabel.text = self.station.id + " " + self.station.label
    self.titleLabel.textAlignment = .left
    self.titleLabel.font = self.titleLabelFont

    // constraints
    self.addSubview(self.titleLabel)
    self.titleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(self.spacing)
      make.centerX.equalToSuperview()
      make.width.equalToSuperview().offset(-2 * self.spacing)
      make.height.equalToSuperview().multipliedBy(0.15)
    }
  }

  private func setupAdressLabel() {
    self.adressLabel = TitleLabelCreator().create()
    self.adressLabel.textAlignment = .left
    self.adressLabel.attributedText = self.adressString

    // constraints
    self.addSubview(self.adressLabel)
    self.adressLabel.snp.makeConstraints { make in
      make.top.equalTo(self.titleLabel.snp.bottom)
      make.centerX.equalToSuperview()
      make.width.equalToSuperview().offset(-2 * self.spacing)
      make.height.equalToSuperview().multipliedBy(0.1)
    }
  }

  private func setupAvailableBikesView() {
    self.availableBikesView = AvailableView(
      frame: .zero,
      image: UIImage(named: "Bike") ?? UIImage(),
      title: "Available bikes",
      countColor: self.station.color,
      count: String(self.station.freeBikes))

    // constraints
    self.addSubview(self.availableBikesView)
    self.availableBikesView.snp.makeConstraints { make in
      make.top.equalTo(self.adressLabel.snp.bottom).offset(self.spacing)
      make.left.equalTo(self.adressLabel.snp.left)
      make.right.equalTo(self.adressLabel.snp.centerX).offset(-self.spacing / 2)
      make.bottom.equalToSuperview().offset(-self.spacing)
    }
  }

  private func setupAvailablePlacesView() {
    self.availablePlacesView = AvailableView(
      frame: .zero,
      image: UIImage(named: "Lock") ?? UIImage(),
      title: "Available places",
      countColor: #colorLiteral(red: 0.2462273836, green: 0.2462682128, blue: 0.2462184131, alpha: 1),
      count: String(self.station.freeRacks))

    // constraints
    self.addSubview(self.availablePlacesView)
    self.availablePlacesView.snp.makeConstraints { make in
      make.top.equalTo(self.adressLabel.snp.bottom).offset(self.spacing)
      make.right.equalTo(self.adressLabel.snp.right)
      make.left.equalTo(self.adressLabel.snp.centerX).offset(self.spacing / 2)
      make.bottom.equalToSuperview().offset(-self.spacing)
    }
  }

  private func update(station: BikeStation) {
    self.adressLabel.attributedText = self.adressString

    self.availableBikesView.count = String(station.freeBikes)
    self.availableBikesView.countColor = station.color

    self.availablePlacesView.count = String(station.freeRacks)
    self.availablePlacesView.countColor = #colorLiteral(red: 0.2462273836, green: 0.2462682128, blue: 0.2462184131, alpha: 1)
  }
}
