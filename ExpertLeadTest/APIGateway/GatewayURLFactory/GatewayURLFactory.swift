import Foundation

class GatewayURLFactory: GatewayURLFactoryContract {

  func makeBaseURL() -> URL {

    // TODO: Switch here based on the environment the app is running against?
    // For example, different URLs could be created for staging and production environments.
    // For now we'll just create the AWSInstance/test URL.

    var components = URLComponents()
    components.scheme = "https"
    components.host = "p0jtvgfrj3.execute-api.eu-central-1.amazonaws.com"
    components.path = "/test"

    guard let url = components.url else {
      preconditionFailure("Precondition failure: failed to create base URL")
    }

    return url
  }

  func makeAuthenticateURL() -> URL {
    let baseURL = makeBaseURL()
    return baseURL.appendingPathComponent("authenticate")
  }
}
