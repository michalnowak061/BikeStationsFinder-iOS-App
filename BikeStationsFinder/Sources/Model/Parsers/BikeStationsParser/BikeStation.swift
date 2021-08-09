import UIKit
import CoreLocation

struct BikeStation {
  // MARK: - Variable's
  var id: String

  var label: String

  var freeBikes: Int

  var freeRacks: Int

  var coordinates: CLLocation

  var adress: String?

  var distance: Float?

  var color: UIColor {
    self.freeBikes > 0 ? #colorLiteral(red: 0.3960784314, green: 0.8196078431, blue: 0.5921568627, alpha: 1) : #colorLiteral(red: 0.8196078431, green: 0.4176940413, blue: 0.4105201383, alpha: 1)
  }

  var distanceString: String? {
    if let distance = self.distance {
      return self.parseDistanceToString(distance)
    } else {
      return nil
    }
  }

  // MARK: - Private function's
  private func parseDistanceToString(_ distance: Float) -> String {
    var string = ""

    if distance > 1000 {
      string = String(format: "%.2f", distance / 1000) + "km"
    } else {
      string = String(format: "%.0f", distance) + "m"
    }

    return string
  }
}
