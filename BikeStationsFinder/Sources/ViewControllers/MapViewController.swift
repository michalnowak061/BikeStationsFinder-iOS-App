import UIKit
import MapKit

class MapViewController: UIViewController {
  // MARK: - Private variable's
  private var mapView: MKMapView!

  private var bikeStationInfoView: BikeStationInfoView!

  private var selectedStationAdress: String! {
    didSet {
      self.updateBikeStationInfoView()
    }
  }

  private var selectedStation: BikeStation? {
    if let selectedStationIndex = self.model.selectedStationIndex {
      var station = self.model.station(atIndex: selectedStationIndex)
      station?.adress = self.selectedStationAdress
      return station
    } else {
      return nil
    }
  }

  // MARK: - Variable's
  weak var coordinator: CoordinatorAdapting?

  var model: BikeStationsManagerAdapting!

  // MARK: - Override's
  init(model: BikeStationsManagerAdapting, coordinator: CoordinatorAdapting?) {
    super.init(nibName: nil, bundle: nil)
    self.model = model
    self.coordinator = coordinator
    self.selectedStationAdress = "Adress is loading..."
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  deinit {
    self.mapView.delegate = nil
  }

  override func loadView() {
    super.loadView()
    self.setup()
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      self.showPopOverView()
    }
    self.setAnnotation()
    self.centerAnnotation()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.model.delegate = self
    self.loadAdress()
  }

  // MARK: - Private function's
  private func setup() {
    self.setupMapView()
    self.setupBikeStationInfoView()
    self.setupPopOverView()
  }

  private func setupMapView() {
    self.mapView = MKMapView()
    self.mapView.showsUserLocation = true
    self.mapView.delegate = self

    self.mapView.register(
      BikeStationAnnotationView.self,
      forAnnotationViewWithReuseIdentifier: NSStringFromClass(BikeStationAnnotationView.self))

    // constraints
    self.view.addSubview(self.mapView)
    self.mapView.snp.makeConstraints { make in
      make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      make.left.right.equalToSuperview()
      make.bottom.equalToSuperview()
    }
  }

  private func setupBikeStationInfoView() {
    guard let station = self.selectedStation else {
      return
    }
    self.bikeStationInfoView = BikeStationInfoView(frame: .zero, station: station)
  }

  private func setAnnotation() {
    guard let station = self.selectedStation else {
      return
    }
    let pin = BikeStationAnnotation(
      title: station.id + " " + station.label,
      coordinate: station.coordinates.coordinate)

    self.mapView.centerToLocation(station.coordinates)
    self.mapView.addAnnotation(pin)
  }

  private func centerAnnotation() {
    guard let station = self.selectedStation else {
      return
    }
    self.mapView.centerToLocation(station.coordinates)
  }

  private func loadAdress() {
    if let index = self.model.selectedStationIndex {
      self.model.fetchAdress(atIndex: index) { adress in
        if let adress = adress {
          self.selectedStationAdress = adress
        } else {
          self.selectedStationAdress = "Adress not found"
        }
      }
    }
  }

  private func updateBikeStationInfoView() {
    if let station = self.selectedStation {
      self.bikeStationInfoView.station = station
    }
  }
}

// MARK: - Extension's
extension MapViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    if annotation is BikeStationAnnotation {
      guard
        let annotationView = self.mapView.dequeueReusableAnnotationView(
          withIdentifier: NSStringFromClass(BikeStationAnnotationView.self),
          for: annotation) as? BikeStationAnnotationView
      else {
        fatalError("\(NSStringFromClass(BikeStationAnnotationView.self)) not found")
      }

      if let station = self.selectedStation {
        annotationView.icon = UIImage(named: "Bike")
        annotationView.count = String(station.freeBikes)
        annotationView.color = station.color
      }

      return annotationView
    } else {
      return nil
    }
  }

  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    self.showPopOverView()
    self.centerAnnotation()
  }

  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesMoved(touches, with: event)

    self.hidePopOverView()
    self.mapView.deselectAllAnnotations()
  }
}

extension MapViewController: ImplementingPopOverView {
  var popOverView: UIView {
    self.bikeStationInfoView
  }

  var heigth: CGFloat {
    UIScreen.main.bounds.size.height * 0.3
  }

  var animationDuration: TimeInterval {
    0.5
  }
}

extension MapViewController: BikeStationsManagerDelegate {
  func bikeStationsManager(bikeStationsManager: BikeStationsManager, stations didUpdate: [BikeStation]) {
    self.updateBikeStationInfoView()
  }
}
