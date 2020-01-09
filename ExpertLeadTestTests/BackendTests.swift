import XCTest

@testable
import ExpertLeadTest

class BackendTests: XCTestCase {

  var backend: Backend!

  override func setUp() {
    let baseURL = URL(string: "https://42.com")!
    backend = Backend(baseURL: baseURL)
  }

  override func tearDown() {
    backend = nil
  }

  func testTheBackendHasTheCorrectBaseURLIncludingTestPathComponent() {

    let baseURLWithTestPathComponent = backend.makeBaseUrlWithTestPathComponent()
    XCTAssertEqual(baseURLWithTestPathComponent.absoluteString, "https://42.com/test", "The base URL should be created correctly")
  }

  func testMakingAnEndpointToAuthenticateAUser() {

    let user = User(email: "42@42.com", password: "FortyTwo:42")
    let endpoint = backend.makeEndpointToAuthenticate(user: user)

    let expectedEndpointDescription = "POST https://42.com/test/authenticate {\"email\":\"42@42.com\",\"password\":\"FortyTwo:42\"}"
    XCTAssertEqual(endpoint.description, expectedEndpointDescription, "The authentication endpoint should be created correctly")
  }
}
