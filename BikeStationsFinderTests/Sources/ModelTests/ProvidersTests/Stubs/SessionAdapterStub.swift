import Foundation
import Alamofire
@testable import BikeStationsFinder

class SessionAdapterStub: SessionAdapterAdapting {
  private let stations: BikeStations = bikeStationsStub

  var withSucess = true

  func response(_ convertible: URLConvertible, completionHandler: @escaping (AFError?, BikeStations?) -> Void) {
    let error: AFError? = self.withSucess ? nil : AFError.explicitlyCancelled
    completionHandler(error, self.stations)
  }
}
