import UIKit
import SnapKit
import AMDots

class LoadingViewController: UIViewController {
  // MARK: - Private variable's
  private var titleLabel: UILabel!

  private var infoLabel: UILabel!

  private var titleLabelFont: UIFont {
    UIFont(name: "Helvetica-Bold", size: UIScreen.main.bounds.size.height * 0.1) ?? UIFont()
  }

  private var infoLabelFont: UIFont {
    UIFont(name: "Helvetica-Light", size: UIScreen.main.bounds.size.height * 0.02) ?? UIFont()
  }

  // MARK: - Variable's
  weak var coordinator: CoordinatorAdapting?

  var model: BikeStationsManagerAdapting!

  var dotsView: AMDots!

  // MARK: - Override's
  init(
    model: BikeStationsManagerAdapting = BikeStationsManager(),
    coordinator: CoordinatorAdapting?
  ) {
    super.init(nibName: nil, bundle: nil)
    self.model = model
    self.coordinator = coordinator
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  override func loadView() {
    super.loadView()
    self.setup()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.fetchData()
  }

  override var prefersStatusBarHidden: Bool {
    return true
  }

  // MARK: - Function's
  func fetchData() {
    self.model.fetchData { succes in
      if succes {
        self.model.sort(option: .sortByID)
        self.showListCoordinator()
      } else {
        self.showOkAlert(title: "Connection error", message: "Check internet connection") { _ in
          self.fetchData()
        }
      }
    }
  }

  // MARK: - Private function's
  private func setup() {
    self.setupAMDots()
    self.setupTitleLabel()
    self.setupInfoLabel()
  }

  private func setupAMDots() {
    self.dotsView = AMDots(frame: .zero, colors: [#colorLiteral(red: 0.2470588235, green: 0.2470588235, blue: 0.2470588235, alpha: 1), #colorLiteral(red: 0.3098039216, green: 0.4274509804, blue: 0.3568627451, alpha: 1), #colorLiteral(red: 0.3607843137, green: 0.6196078431, blue: 0.4705882353, alpha: 1), #colorLiteral(red: 0.3960784314, green: 0.8196078431, blue: 0.5921568627, alpha: 1)])
    self.dotsView.backgroundColor = .none
    self.dotsView.animationType = .scale

    // constraints
    self.view.addSubview(dotsView)
    self.dotsView.snp.makeConstraints { make in
      make.width.equalTo(self.view.snp.width).multipliedBy(0.5)
      make.height.equalTo(self.view.snp.height).multipliedBy(0.1)
      make.center.equalToSuperview()
    }
  }

  private func setupTitleLabel() {
    self.titleLabel = TitleLabelCreator().create()
    self.titleLabel.font = self.titleLabelFont
    self.titleLabel.text = "Bike Stations Finder"

    // constraints
    self.view.addSubview(self.titleLabel)
    self.titleLabel.snp.makeConstraints { make in
      make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      make.width.equalToSuperview().offset(-40)
      make.bottom.equalTo(self.dotsView.snp.top)
      make.centerX.equalToSuperview()
    }
  }

  private func setupInfoLabel() {
    self.infoLabel = TitleLabelCreator().create()
    self.infoLabel.font = self.infoLabelFont
    self.infoLabel.text = "Retrieving data"

    // constraints
    self.view.addSubview(self.infoLabel)
    self.infoLabel.snp.makeConstraints { make in
      make.top.equalTo(self.dotsView.snp.bottom)
      make.width.equalTo(self.dotsView.snp.width).multipliedBy(0.5)
      make.height.equalTo(self.dotsView.snp.height).multipliedBy(0.5)
      make.centerX.equalToSuperview()
    }
  }

  private func showListCoordinator() {
    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
      if let coordinator = self.coordinator as? AppCoordinator, let model = self.model {
        coordinator.showListCoordinator(model: model)
      }
    }
  }
}
