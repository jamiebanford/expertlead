import Foundation

class TinyNetworkingAPIGateway: APIGatewayContract {

  // MARK: - Public properties

  var isRequestCurrentlyInProgress = false

  // MARK: - Private properties

  private let endpointFactory = TinyNetworkingEndpointFactory()
  private let urlSession: URLSession

  private var currentURLSessionDataTask: URLSessionDataTask?

  // MARK: -

  init(urlSession: URLSession = URLSession.shared) {
    self.urlSession = urlSession
  }

  func authenticate(credentials: Credentials,
                    onSuccess: @escaping (SuccessfulAuthenticationResponse) -> (),
                    onFailure: @escaping (APIAuthenticationError) -> ()) {

    isRequestCurrentlyInProgress = true

    let endpoint = endpointFactory.makeEndpointToAuthenticate(credentials: credentials)

    currentURLSessionDataTask = urlSession.load(endpoint) { [weak self] result in
      switch result {
        case .success(let response):
          self?.isRequestCurrentlyInProgress = false

          if let token = response.token {
            let response = SuccessfulAuthenticationResponse(token: token, message: response.message)
            onSuccess(response)
          } else {
            let error = APIAuthenticationError(message: response.message)
            onFailure(error)
        }
        case .failure(let error):
          self?.isRequestCurrentlyInProgress = false

          // TODO: Handle this case more neatly...
          let authenticationError = APIAuthenticationError(errorDescription: error.localizedDescription)
          onFailure(authenticationError)
      }
    }
  }

  func cancelCurrentRequest() {
    isRequestCurrentlyInProgress = false
    currentURLSessionDataTask?.cancel()
  }
}
