import XCTest
import CoreLocation
@testable import BikeStationsFinder

class BikeStationsParserTests: XCTestCase {
  var sut: BikeStationsParserAdapting!

  override func setUp() {
    self.sut = BikeStationsParser()
    super.setUp()
  }

  override func tearDown() {
    self.sut = nil
    super.tearDown()
  }

  func testParse() {
    let stub = bikeStationsStub
    let result = sut.parse(bikeStations: stub)

    XCTAssertEqual(result.count, 1)
    XCTAssertEqual(result[0].id, "0000")
    XCTAssertEqual(result[0].freeRacks, 0)
    XCTAssertEqual(result[0].freeBikes, 0)
    XCTAssertEqual(result[0].coordinates.coordinate.latitude, 0)
    XCTAssertEqual(result[0].coordinates.coordinate.longitude, 0)
  }
}
