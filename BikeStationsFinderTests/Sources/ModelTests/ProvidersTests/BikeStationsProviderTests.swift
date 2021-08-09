import XCTest
import Alamofire
@testable import BikeStationsFinder

class BikeStationsProviderTests: XCTestCase {
  var sut: BikeStationsProviderAdapting!

  var stub: SessionAdapterStub!

  var mock: BikeStationsParserMock!

  override func setUp() {
    self.stub = SessionAdapterStub()
    self.mock = BikeStationsParserMock()
    self.sut = BikeStationsProvider(session: self.stub, parser: self.mock)
    super.setUp()
  }

  override func tearDown() {
    self.mock = nil
    self.sut = nil
    super.tearDown()
  }

  func testSuccess() {
    let expectation = self.expectation(description: "testSuccess")
    var isSuccess = false

    self.stub.withSucess = true
    self.sut.fetch { response in
      switch response {
      case .success:
        isSuccess = true
      case .failure:
        break
      }
      expectation.fulfill()
    }

    waitForExpectations(timeout: 0.1, handler: nil)

    XCTAssertEqual(isSuccess, true)
    XCTAssertEqual(self.mock.parseCallCount, 1)
  }

  func testFail() {
    let expectation = self.expectation(description: "testFail")
    var isFail = false

    self.stub.withSucess = false
    self.sut.fetch { response in
      switch response {
      case .success:
        break
      case .failure:
        isFail = true
      }
      expectation.fulfill()
    }

    waitForExpectations(timeout: 0.1, handler: nil)

    XCTAssertEqual(isFail, true)
    XCTAssertEqual(self.mock.parseCallCount, 0)
  }
}
