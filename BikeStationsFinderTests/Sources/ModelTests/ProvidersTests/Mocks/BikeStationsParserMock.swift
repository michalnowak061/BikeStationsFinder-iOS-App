import Foundation
@testable import BikeStationsFinder

class BikeStationsParserMock: BikeStationsParserAdapting {
  var parseCallCount: Int = 0

  func parse(bikeStations: BikeStations) -> [BikeStation] {
    self.parseCallCount += 1
    return []
  }
}
