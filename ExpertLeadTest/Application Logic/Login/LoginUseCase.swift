import Foundation

class LoginUseCase {

  // MARK: - Public properties

  weak var delegate: LoginUseCaseDelegate?

  // MARK: - Private properties

  private let apiGateway: APIGatewayContract

  private var currentEmailText: String?
  private var currentPasswordText: String?

  // MARK: Initialisers

  init(apiGateway: APIGatewayContract) {
    self.apiGateway = apiGateway
  }
}

// MARK: - Public API

extension LoginUseCase: LoginUseCaseContract {

  func update(emailText newEmailText: String) {

    let isCurrentEmailTextValid = isValid(emailText: currentEmailText)
    let isNewEmailTextValid = isValid(emailText: newEmailText)

    switch (isCurrentEmailTextValid, isNewEmailTextValid) {
      case (nil, false), (true, false):
        delegate?.emailTextDidBecomeInvalid()
      case (nil, true), (false, true):
        delegate?.emailTextDidBecomeValid()
      default:
        break
    }

    let isCurrentPasswordValid = isValid(passwordText: currentPasswordText)

    switch (isCurrentEmailTextValid, isNewEmailTextValid, isCurrentPasswordValid) {
      case (nil, false, true), (true, false, true):
        delegate?.shouldDisableCallToAction()
      case (nil, true, true), (false, true, true):
        delegate?.shouldEnableCallToAction()
      default:
        break
    }

    currentEmailText = newEmailText
  }

  func update(passwordText newPasswordText: String) {

    let isCurrentPasswordTextValid = isValid(passwordText: currentPasswordText)
    let isNewPasswordTextValid = isValid(passwordText: newPasswordText)

    switch (isCurrentPasswordTextValid, isNewPasswordTextValid) {
      case (nil, false), (true, false):
        delegate?.passwordTextDidBecomeInvalid()
      case (nil, true), (false, true):
        delegate?.passwordTextDidBecomeValid()
      default:
        break
    }

    let isCurrentEmailValid = isValid(emailText: currentEmailText)

    switch (isCurrentPasswordTextValid, isNewPasswordTextValid, isCurrentEmailValid) {
      case (nil, false, true), (true, false, true):
        delegate?.shouldDisableCallToAction()
      case (nil, true, true), (false, true, true):
        delegate?.shouldEnableCallToAction()
      default:
        break
    }

    currentPasswordText = newPasswordText
  }

  func perform() {

    guard isNotCurrentlyPerformingRequest else {
      cancelCurrentRequest()
      return
    }

    login()
  }

  func reset() {
    currentEmailText = nil
    currentPasswordText = nil
  }
}

private extension LoginUseCase {

  // MARK: - Validation logic

  func isValid(emailText: String?) -> Bool? {
    guard let email = emailText else {
      return nil
    }

    return email.contains("@")
  }

  func isValid(passwordText: String?) -> Bool? {
    guard let password = passwordText else {
      return nil
    }

    return !password.isEmpty
  }

  // MARK: - API Gateway

  var isNotCurrentlyPerformingRequest: Bool {
    return !apiGateway.isRequestCurrentlyInProgress
  }

  func cancelCurrentRequest() {
    apiGateway.cancelCurrentRequest()
  }

  func login() {
    guard
      let email = currentEmailText,
      let password = currentPasswordText
      else { preconditionFailure("Email text or password text not set") }

    delegate?.didStartLoginAttempt()

    let credentials = Credentials(email: email, password: password)
    apiGateway.authenticate(credentials: credentials,
                            onSuccess: { [weak self] response in

                              // TODO: Do something with the email & token. Maybe they should persist for future calls to secure endpoints?
                              let user = AuthenticatedUser(email: email, token: response.token)

                              DispatchQueue.main.async {
                                self?.delegate?.didSuccessfullyAuthenticate(user: user)
                              }
    },
                            onFailure: { [weak self] error in

                              // TODO: Find a neater way to transform the API error into a presentable error
                              let message = error.message ?? error.description
                              let presentableError = PresentableError(message: message)

                              DispatchQueue.main.async {
                                self?.delegate?.didFailToAuthenticateUserWithError(error: presentableError)
                              }
    })
  }
}
