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

  var currentEmail: String?
  var currentPassword: String?

  // MARK: - Life cycle

  init(apiGateway: APIGatewayContract) {
    self.apiGateway = apiGateway
  }

  func authenticate(user: Credentials,
                    onSuccess: @escaping (AuthenticatedUser) -> (),
                    onFailure: @escaping (DisplayableError) -> ()) {
    apiGateway.authenticate(user: user, onSuccess: { response in
      let authenticatedUser = AuthenticatedUser(email: user.email, token: response.token)
      onSuccess(authenticatedUser)
    }) { apiError in
      // TODO: Explore how to transform an API message into a display message
      let displayMessage = apiError.message ?? "A generic error message"
      let displayableError = DisplayableError(message: displayMessage)
      onFailure(displayableError)
    }
  }

  // MARK: - Private helper methods

  private func isValid(email newEmail: String) -> Bool {
    return newEmail.contains("@")
  }

  private func isValid(password newPassword: String) -> Bool {
    return !newPassword.isEmpty
  }
}
