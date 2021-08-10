import XCTest
@testable import BikeStationsFinder

class UserTrackerTests: XCTestCase {
  var sut: UserTracker!

  override func setUp() {
    self.sut = UserTracker()
    super.setUp()
  }

  override func tearDown() {
    self.sut = nil
    super.tearDown()
  }

  func testInit() {
    XCTAssertNotNil(self.sut.locationManager)
    XCTAssertNotNil(self.sut.locationManager.delegate)
  }
}
