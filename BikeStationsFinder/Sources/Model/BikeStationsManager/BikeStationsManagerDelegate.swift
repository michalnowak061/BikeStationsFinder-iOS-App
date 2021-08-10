import Foundation

// periphery: ignore
protocol BikeStationsManagerDelegate: AnyObject {
  func bikeStationsManager(bikeStationsManager: BikeStationsManager, stations didUpdate: [BikeStation])
}
