import Foundation

class LoginUseCase: LoginUseCaseContract {

  // MARK: - Public properties

  let apiGateway: APIGatewayContract

  var hasValidCredentials: (validEmail: Bool, validPassword: Bool) {

    return (isValid(email: currentEmail), isValid(password: currentPassword))
  }

  var isLoginAttemptInProgress = false

  // MARK: Private API

  private var currentEmail: String?
  private var currentPassword: String?

  // MARK: - Life cycle

  init(apiGateway: APIGatewayContract) {
    self.apiGateway = apiGateway
  }

  // MARK: - Public API

  func update(email newEmail: String) {
    currentEmail = newEmail
  }

  func update(password newPassword: String) {
    currentPassword = newPassword
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

  private func isValid(email newEmail: String?) -> Bool {
    guard let email = newEmail else {
      return false
    }

    return email.contains("@")
  }

  private func isValid(password newPassword: String?) -> Bool {
    guard let password = newPassword else {
      return false
    }

    return !password.isEmpty
  }
}
