import Foundation
import Alamofire

class BikeStationsProvider: BikeStationsProviderAdapting {
  var session: SessionAdapterAdapting!

  var parser: BikeStationsParserAdapting!

  init(
    session: SessionAdapterAdapting = SessionAdapter(),
    parser: BikeStationsParserAdapting = BikeStationsParser()
  ) {
    self.session = session
    self.parser = parser
  }

  func fetch(completion: @escaping BikeStationsFetchCompletion) {
    self.session.response(URLStorage.poznanBikeStations.rawValue) { error, responseValue in
      if let error = error {
        completion(.failure(error))
        return
      }
      guard let bikeStations = responseValue else {
        return
      }
      let stations = self.parser.parse(bikeStations: bikeStations)
      completion(.success(stations))
    }
  }
}
