import Foundation

class LoginUseCase: LoginUseCaseContract {

  let apiGateway: APIGatewayContract

  init(apiGateway: APIGatewayContract) {
    self.apiGateway = apiGateway
  }

  func validate(email newEmail: String) -> Bool {
    return newEmail.contains("@")
  }

  func validate(password newPassword: String) -> Bool {
    return !newPassword.isEmpty
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
}
