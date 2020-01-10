import Foundation

class LoginInteractor: LoginInteractorContract {

  let apiGateway: APIGatewayContract

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
}
