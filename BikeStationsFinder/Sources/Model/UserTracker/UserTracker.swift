import Foundation
import MapKit

class UserTracker: NSObject, UserTrackerAdapting {
  // MARK: - Private variable's
  private var userLocation: CLLocation?

  // MARK: - Private constant's
  private let offsetCutoff: CLLocationDegrees = 2e-04

  // MARK: - Variable's
  weak var delegate: UserTrackerDelegate?

  var locationManager: CLLocationManager!

  init(locationManager: CLLocationManager = CLLocationManager()) {
    super.init()
    self.locationManager = locationManager
    self.locationManager.delegate = self
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    self.locationManager.requestAlwaysAuthorization()

    if CLLocationManager.locationServicesEnabled() {
      self.locationManager.startUpdatingLocation()
    }
  }
}

extension UserTracker: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let currentLocation: CLLocation = locations[0] as CLLocation

    if let userLocation = self.userLocation {
      let latitudeOffset = userLocation.coordinate.latitude - currentLocation.coordinate.latitude
      let longitudeOffset = userLocation.coordinate.longitude - currentLocation.coordinate.longitude

      if abs(latitudeOffset) > self.offsetCutoff || abs(longitudeOffset) > self.offsetCutoff {
        self.userLocation = currentLocation
        self.delegate?.userTracker(userTracker: self, didChange: currentLocation)
      }
    } else {
      self.delegate?.userTracker(userTracker: self, didChange: currentLocation)
      self.userLocation = currentLocation
    }
  }
}
