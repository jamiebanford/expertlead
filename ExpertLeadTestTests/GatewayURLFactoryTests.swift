import XCTest

@testable
import ExpertLeadTest

class GatewayURLFactoryTests: XCTestCase {

  var urlFactory: GatewayURLFactory!

  override func setUp() {
    urlFactory = GatewayURLFactory()
  }

  override func tearDown() {
    urlFactory = nil
  }

  func testBaseURL() {

    let url = urlFactory.makeBaseURL()
    XCTAssertEqual(url.absoluteString, "https://p0jtvgfrj3.execute-api.eu-central-1.amazonaws.com/test", "The base URL should be created correctly")
  }

  func testAuthenticateURL() {

    let url = urlFactory.makeAuthenticateURL()
    XCTAssertEqual(url.absoluteString, "https://p0jtvgfrj3.execute-api.eu-central-1.amazonaws.com/test/authenticate", "The authenticate URL should be created correctly")
  }
}
