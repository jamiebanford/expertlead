import Foundation
import TinyNetworking

class TinyNetworkingAPIGateway: APIGatewayContract {

  // MARK: - Private properties

  private let urlSession: URLSession
  private let urlFactory: GatewayURLFactoryContract

  private var currentURLSessionDataTask: URLSessionDataTask?

  // MARK: - Life cycle

  init(urlFactory: GatewayURLFactoryContract, urlSession: URLSession = URLSession.shared) {
    self.urlFactory = urlFactory
    self.urlSession = urlSession
  }

  // MARK: - Public methods

  func authenticate(credentials: Credentials,
                    onSuccess: @escaping (SuccessfulAuthenticationResponse) -> (),
                    onFailure: @escaping (APIAuthenticationError) -> ()) {

    let endpoint = makeEndpointToAuthenticate(credentials: credentials)

    currentURLSessionDataTask = urlSession.load(endpoint) { result in
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

  func cancelCurrentRequest() {
    currentURLSessionDataTask?.cancel()
  }
}

// MARK: Authentication helpers

private extension TinyNetworkingAPIGateway {

  /// The response of the authenticate call. Successfully authenticated users will receive a token.
  struct AuthenticationResponse: Codable {
    let token: String?
    let message: String
  }

  func makeEndpointToAuthenticate(credentials: Credentials) -> Endpoint<TinyNetworkingAPIGateway.AuthenticationResponse> {

    let url = urlFactory.makeAuthenticateURL()
    let endpoint = Endpoint<AuthenticationResponse>(json: .post,
                                                    url: url,
                                                    body: credentials,
                                                    expectedStatusCode: { code in
                                                      return code == 200 || code == 401 || code == 500
    })

    return endpoint
  }
}
