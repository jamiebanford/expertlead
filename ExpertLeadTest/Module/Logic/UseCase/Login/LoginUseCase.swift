import Foundation

class LoginUseCase: LoginUseCaseContract {

  // MARK: - Public properties

  let apiGateway: APIGatewayContract

  var hasValidCredentials: Bool {
    guard
         let email = currentEmail,
         let password = currentPassword
         else { return false }

    return isValid(email: email) && isValid(password: password)
  }

  var isLoginAttemptInProgress = false
  var currentEmail: String?
  var currentPassword: String?

  // MARK: - Life cycle

  init(apiGateway: APIGatewayContract) {
    self.apiGateway = apiGateway
  }

  func authenticate(onSuccess: @escaping (AuthenticatedUser) -> (),
                    onFailure: @escaping (DisplayableError) -> ()) {
    guard
      let email = currentEmail,
      let password = currentPassword
      else { return }

    isLoginAttemptInProgress = true

    let credentials = Credentials(email: email, password: password)

    apiGateway.authenticate(credentials: credentials, onSuccess: { [weak self] response in

      self?.isLoginAttemptInProgress = false

      let authenticatedUser = AuthenticatedUser(email: credentials.email, token: response.token)
      onSuccess(authenticatedUser)

    }) { [weak self] apiError in

      self?.isLoginAttemptInProgress = false

      // TODO: Explore how to transform an API message into a display message
      let displayMessage = apiError.message ?? "A generic error message"
      let displayableError = DisplayableError(message: displayMessage)
      onFailure(displayableError)
    }
  }

  func cancelAuthenticationRequest() {
    apiGateway.cancelCurrentRequest()
  }

  // MARK: - Private helper methods

  private func isValid(email newEmail: String) -> Bool {
    return newEmail.contains("@")
  }

  private func isValid(password newPassword: String) -> Bool {
    return !newPassword.isEmpty
  }
}
