import UIKit

class ListViewController: UIViewController {
  // MARK: - Private variable's
  private var collectionViewFlowLayout: UICollectionViewFlowLayout!

  private var collectionView: UICollectionView!

  private var refreshControl: UIRefreshControl!

  private var cellSpacing: CGFloat {
    self.view.frame.width * 0.03
  }

  // MARK: - Variable's
  weak var coordinator: CoordinatorAdapting?

  var model: BikeStationsManagerAdapting!

  // MARK: - Override's
  init(model: BikeStationsManagerAdapting, coordinator: CoordinatorAdapting?) {
    super.init(nibName: nil, bundle: nil)
    self.refreshControl = UIRefreshControl()
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

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.model.delegate = self
    self.collectionView.reloadData()
  }

  // MARK: - Private function's
  private func setup() {
    self.setupRefreshControl()
    self.setupCollectionView()
  }

  private func setupRefreshControl() {
    self.refreshControl = UIRefreshControl()
    self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    self.refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
  }

  @objc private func fetchData() {
    self.model.fetchData { succes in
      if succes {
        self.model.sort(option: .sortByID)
        self.collectionView.reloadData()
        self.refreshControl.endRefreshing()
      } else {
        self.showOkAlert(title: "Connection error", message: "Check internet connection") { _ in
          self.fetchData()
        }
      }
    }
  }

  private func setupCollectionView() {
    self.collectionViewFlowLayout = UICollectionViewFlowLayout()
    self.collectionViewFlowLayout.scrollDirection = .vertical
    self.collectionViewFlowLayout.minimumLineSpacing = self.cellSpacing

    self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewFlowLayout)
    self.collectionView.refreshControl = self.refreshControl
    self.collectionView.indicatorStyle = .black
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    self.collectionView.register(
      BikeStationCollectionViewCell.self,
      forCellWithReuseIdentifier: BikeStationCollectionViewCell.identifier)

    self.collectionView.contentInset.top = self.cellSpacing
    self.collectionView.contentInset.bottom = self.cellSpacing

    self.collectionView.isScrollEnabled = true
    self.collectionView.alwaysBounceVertical = true
    self.collectionView.backgroundColor = .none

    // constraints
    self.view.addSubview(self.collectionView)
    self.collectionView.snp.makeConstraints { make in
      make.width.equalTo(self.view.safeAreaLayoutGuide.snp.width)
      make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      make.bottom.equalTo(self.view.snp.bottom)
      make.centerX.equalToSuperview()
    }
  }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    self.model.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard
      let cell = self.collectionView.dequeueReusableCell(
        withReuseIdentifier: BikeStationCollectionViewCell.identifier,
        for: indexPath) as? BikeStationCollectionViewCell
    else {
      fatalError("\(BikeStationCollectionViewCell.identifier) not found")
    }

    if let station = self.model.station(atIndex: indexPath.row) {
      cell.subview = BikeStationInfoView(frame: .zero, station: station)
    }

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.model.selectedStationIndex = indexPath.row

    if let coordinator = self.coordinator as? ListCoordinator {
      coordinator.showMapViewController()
    }
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ListViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let spacing: CGFloat = self.cellSpacing
    let numberOfItemsPerRow: CGFloat = 1
    let spacingBetweenCells: CGFloat = self.cellSpacing

    let totalSpacing = (2 * spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)

    let width = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
    let height = collectionView.frame.height / 3
    return CGSize(width: width, height: height)
  }
}

// MARK: - BikeStationsManagerDelegate
extension ListViewController: BikeStationsManagerDelegate {
  func bikeStationsManager(bikeStationsManager: BikeStationsManager, stations didUpdate: [BikeStation]) {
    self.collectionView.reloadData()
  }
}
