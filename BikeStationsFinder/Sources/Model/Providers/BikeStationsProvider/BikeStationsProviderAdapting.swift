import Foundation

typealias BikeStationsFetchCompletion = ((Result<[BikeStation], Error>)?) -> Void

protocol BikeStationsProviderAdapting {
  // periphery: ignore
  var session: SessionAdapterAdapting { get set }

  // periphery: ignore
  var parser: BikeStationsParserAdapting { get set }

  // periphery: ignore
  init(session: SessionAdapterAdapting, parser: BikeStationsParserAdapting)

  func fetch(completion: @escaping BikeStationsFetchCompletion)
}
