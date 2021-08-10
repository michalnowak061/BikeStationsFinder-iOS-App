import XCTest
@testable import BikeStationsFinder

class BikeStationsManagerTests: XCTestCase {
  var sut: BikeStationsManager!

  override func setUp() {
    self.sut = BikeStationsManager()
    super.setUp()
  }

  override func tearDown() {
    self.sut = nil
    super.tearDown()
  }

  func testInit() {
    XCTAssertNotNil(self.sut.provider)
    XCTAssertNotNil(self.sut.tracker)
    XCTAssertNotNil(self.sut.tracker.delegate)
  }

  func testSetStations() {
    let count = self.sut.count

    self.sut.setStations(stations: [bikeStationStub])
    XCTAssertEqual(self.sut.count, count + 1)
  }

  func testSort() {
    var bikeStationsStub: [BikeStation] = [
      bikeStationStub,
      bikeStationStub,
      bikeStationStub
    ]

    bikeStationsStub[0].id = "3"
    bikeStationsStub[1].id = "2"
    bikeStationsStub[2].id = "1"

    self.sut.setStations(stations: bikeStationsStub)
    self.sut.sort(option: .sortByID)

    XCTAssertEqual(self.sut.station(atIndex: 0)?.id, "1")
    XCTAssertEqual(self.sut.station(atIndex: 1)?.id, "2")
    XCTAssertEqual(self.sut.station(atIndex: 2)?.id, "3")
  }

  func testStationAtIndex() {
    let bikeStationsStub: [BikeStation] = [
      bikeStationStub
    ]

    self.sut.setStations(stations: bikeStationsStub)
    XCTAssertNotNil(self.sut.station(atIndex: 0))
    XCTAssertNil(self.sut.station(atIndex: 1))
  }
}
