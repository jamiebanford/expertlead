import Foundation
import TinyNetworking

class TinyNetworkingAPIGateway: APIGatewayContract {

  // MARK: - Private properties

  private let baseURL: URL
  private let urlSession: URLSession

  // MARK: - Life cycle

  init(baseURL: URL, urlSession: URLSession = URLSession.shared) {
    self.baseURL = baseURL
    self.urlSession = urlSession
  }

  // MARK: - Public methods

  func authenticate(user: Credentials,
                    onSuccess: @escaping (SuccessfulAuthenticationResponse) -> (),
                    onFailure: @escaping (APIAuthenticationError) -> ()) {

    let endpoint = makeEndpointToAuthenticate(user: user)

    urlSession.load(endpoint) { result in
      switch result {
        case .success(let response):
          if let token = response.token {
            let response = SuccessfulAuthenticationResponse(token: token, message: response.message)
            onSuccess(response)
          } else {
            let error = APIAuthenticationError(message: response.message)
            onFailure(error)
        }
        case .failure(let error):
          // TODO: Handle this case more neatly...
          let error = APIAuthenticationError(errorDescription: error.localizedDescription)
          onFailure(error)
      }
    }
  }

  // TODO: Move these the the URL factory/builder
  // MARK: - URL path components

  enum PathComponent: String {
    case authenticate
    case test
  }

  func makeBaseUrlWithTestPathComponent() -> URL {
    baseURL.appendingPathComponent(TinyNetworkingAPIGateway.PathComponent.test.rawValue)
  }
}

// MARK: Authentication helpers

private extension TinyNetworkingAPIGateway {

  /// The response of the authenticate call. Successfully authenticated users will receive a token.
  struct AuthenticationResponse: Codable {
    let token: String?
    let message: String
  }

  /// Returns `true` if `code` is in the 200..<300 range, or the code is 401 or 500.
  func expectedTestCode(_ code: Int) -> Bool {
    return code >= 200 && code < 300 || code == 401 || code == 500
  }

  // TODO: Move to an endpoint factory
  func makeEndpointToAuthenticate(user: Credentials) -> Endpoint<TinyNetworkingAPIGateway.AuthenticationResponse> {

    let url = makeAuthenticateURL()
    let endpoint = Endpoint<AuthenticationResponse>(json: .post,
                                                    url: url,
                                                    body: user,
                                                    expectedStatusCode: expectedTestCode(_:))

    return endpoint
  }

  // TODO: Move this the the URL factory/builder
  func makeAuthenticateURL() -> URL {
    let baseURL = makeBaseUrlWithTestPathComponent()
    return baseURL.appendingPathComponent(TinyNetworkingAPIGateway.PathComponent.authenticate.rawValue)
  }
}
