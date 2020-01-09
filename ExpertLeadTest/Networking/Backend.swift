import Foundation
import TinyNetworking

class Backend {

  // MARK: - Private properties

  private let baseURL: URL

  // MARK: - Life cycle

  init(baseURL: URL) {
    self.baseURL = baseURL
  }

  // MARK: - URL path components

  enum PathComponent: String {
    case authenticate
    case test
  }

  func makeBaseUrlWithTestPathComponent() -> URL {
    baseURL.appendingPathComponent(Backend.PathComponent.test.rawValue)
  }
}

// MARK: Authenticate

/// The user credentials to be authenticated
struct User: Codable {
  let email: String
  let password: String
}

/// The response of the authenticate call. Successfully authenticated users will receive a token.
struct AuthenticationResponse: Codable {
  let token: String?
  let message: String
}

extension Backend {
  func makeEndpointToAuthenticate(user: User) -> Endpoint<AuthenticationResponse> {
    let url = makeAuthenticateURL()
    let endpoint = Endpoint<AuthenticationResponse>(json: .post,
                                                    url: url,
                                                    body: user)

    return endpoint
  }

  private func makeAuthenticateURL() -> URL {
    let baseURL = makeBaseUrlWithTestPathComponent()
    return baseURL.appendingPathComponent(Backend.PathComponent.authenticate.rawValue)
  }
}
