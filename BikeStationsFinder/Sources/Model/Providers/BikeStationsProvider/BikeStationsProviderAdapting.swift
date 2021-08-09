import Foundation

typealias BikeStationsFetchCompletion = (Result<[BikeStation], Error>) -> Void

protocol BikeStationsProviderAdapting {
  func fetch(completion: @escaping BikeStationsFetchCompletion)
}
