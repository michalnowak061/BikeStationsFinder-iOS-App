import Foundation
import CoreLocation

class BikeStationsManager: BikeStationsManagerAdapting {
  // MARK: - Private constant's
  private let semaphore = DispatchSemaphore(value: 1)

  private var stations: [BikeStation]

  // MARK: - Variable's
  weak var delegate: BikeStationsManagerDelegate?

  var provider: BikeStationsProviderAdapting!

  var tracker: UserTrackerAdapting!

  var userLocation: CLLocation?

  var count: Int {
    self.stations.count
  }

  var selectedStationIndex: Int?

  // MARK: - Function's
  init(
    provider: BikeStationsProviderAdapting = BikeStationsProvider(),
    tracker: UserTrackerAdapting = UserTracker()
  ) {
    self.provider = provider
    self.tracker = tracker
    self.stations = []

    self.tracker.delegate = self
  }
  
  func setStations(stations: [BikeStation]) {
    self.stations = stations
  }

  func station(atIndex index: Int) -> BikeStation? {
    guard index < self.count else {
      return nil
    }
    return self.stations[index]
  }

  func fetchData(completion: @escaping (Bool) -> Void) {
    self.semaphore.wait()

    self.provider.fetch { result in
      if let result = result {
        switch result {
        case .success:
          if let stations = try? result.get() {
            self.stations = stations
            self.updateDistances()
          }
          completion(true)
        case .failure:
          completion(false)
        }
      }

      self.semaphore.signal()
    }
  }

  func fetchAdress(atIndex index: Int, completion: @escaping (String?) -> Void) {
    guard index < self.count else {
      completion(nil)
      return
    }

    let stationLocation = self.stations[index].coordinates
    self.getAddressFrom(location: stationLocation) { adress in
      completion(adress)
    }
  }

  func sort(option: SortingOptions) {
    switch option {
    case .sortByID:
      self.stations = self.stations.sorted {
        $0.id < $1.id
      }
    }
  }

  // MARK: - Private function's
  private func updateDistances() {
    for index in 0 ..< stations.count {
      let stationLocation = self.stations[index].coordinates
      if let distance = self.calculateDistance(from: stationLocation) {
        self.stations[index].distance = distance
      }
    }
  }

  private func calculateDistance(from location: CLLocation) -> Float? {
    if let userLocation = self.userLocation {
      let distance = userLocation.distance(from: location)
      return Float(distance)
    } else {
      return nil
    }
  }

  private func getAddressFrom(location: CLLocation, completion: @escaping ((String?) -> Void)) {
    CLGeocoder().reverseGeocodeLocation(location) { placemarks, _ in
      if let place = placemarks?.first {
        let description = [
          place.thoroughfare,
          place.subThoroughfare,
          place.locality
        ].compactMap { $0 }.joined(separator: ", ")

        completion(description)
      } else {
        completion(nil)
      }
    }
  }
}

// MARK: - Extension's
extension BikeStationsManager: UserTrackerDelegate {
  func userTracker(userTracker: UserTracker, didChange location: CLLocation) {
    self.userLocation = location
    self.updateDistances()
    self.delegate?.bikeStationsManager(bikeStationsManager: self, stations: self.stations)
  }
}
