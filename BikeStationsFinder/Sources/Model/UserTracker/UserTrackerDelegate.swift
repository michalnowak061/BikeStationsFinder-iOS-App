import Foundation
import CoreLocation

// periphery: ignore
protocol UserTrackerDelegate: AnyObject {
  func userTracker(userTracker: UserTracker, didChange location: CLLocation)
}
