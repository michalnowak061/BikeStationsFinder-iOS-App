import XCTest
import Alamofire
@testable import BikeStationsFinder

class BikeStationsProviderTests: XCTestCase {
  var sut: BikeStationsProvider!

  var stub: SessionAdapterStub!

  var mock: BikeStationsParserMock!

  override func setUp() {
    self.stub = SessionAdapterStub()
    self.mock = BikeStationsParserMock()
    self.sut = BikeStationsProvider(session: self.stub, parser: self.mock)
    super.setUp()
  }

  override func tearDown() {
    self.stub = nil
    self.mock = nil
    self.sut = nil
    super.tearDown()
  }

  func testInit() {
    XCTAssertNotNil(self.sut.session)
    XCTAssertNotNil(self.sut.parser)
  }

  func testShouldEndWithSuccess() {
    let expectation = self.expectation(description: "testSuccess")
    var isSuccess = false

    self.stub.withSucess = true
    self.sut.fetch { response in
      if let response = response {
        switch response {
        case .success:
          isSuccess = true
        case .failure:
          break
        }
        expectation.fulfill()
      }
    }

    waitForExpectations(timeout: 0.1, handler: nil)

    XCTAssertEqual(isSuccess, true)
    XCTAssertEqual(self.mock.parseCallCount, 1)
  }

  func testShouldEndWithFail() {
    let expectation = self.expectation(description: "testFail")
    var isFail = false

    self.stub.withSucess = false
    self.sut.fetch { response in
      if let response = response {
        switch response {
        case .success:
          break
        case .failure:
          isFail = true
        }
        expectation.fulfill()
      }
    }

    waitForExpectations(timeout: 0.1, handler: nil)

    XCTAssertEqual(isFail, true)
    XCTAssertEqual(self.mock.parseCallCount, 0)
  }
}
