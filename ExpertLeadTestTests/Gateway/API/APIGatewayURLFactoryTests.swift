import XCTest

@testable
import ExpertLeadTest

class APIGatewayURLFactoryTests: XCTestCase {

  // MARK: - Object under test

  var urlFactory: APIGatewayURLFactory!

  // MARK: - Set up and tear down

  override func setUp() {
    urlFactory = APIGatewayURLFactory()
  }

  override func tearDown() {
    urlFactory = nil
  }

  // MARK: - Base URL tests

  func testBaseURL() {

    let url = urlFactory.makeBaseURL()
    XCTAssertEqual(url.absoluteString, "https://p0jtvgfrj3.execute-api.eu-central-1.amazonaws.com/test", "The base URL should be created correctly")
  }

  // MARK: - Authenticate URL tests

  func testAuthenticateURL() {

    let url = urlFactory.makeAuthenticateURL()
    XCTAssertEqual(url.absoluteString, "https://p0jtvgfrj3.execute-api.eu-central-1.amazonaws.com/test/authenticate", "The authenticate URL should be created correctly")
  }
}
