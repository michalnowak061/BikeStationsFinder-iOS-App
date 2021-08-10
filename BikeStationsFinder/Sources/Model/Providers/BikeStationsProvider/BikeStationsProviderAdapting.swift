import Foundation

typealias BikeStationsFetchCompletion = ((Result<[BikeStation], Error>)?) -> Void

protocol BikeStationsProviderAdapting {
  var session: SessionAdapterAdapting { get set }

  var parser: BikeStationsParserAdapting { get set }

  init(session: SessionAdapterAdapting, parser: BikeStationsParserAdapting)

  func fetch(completion: @escaping BikeStationsFetchCompletion)
}
