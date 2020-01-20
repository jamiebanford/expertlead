import Foundation

protocol LoginUseCaseContract: class {

  func update(emailText newEmailText: String)
  func update(passwordText newPasswordText: String)

  func perform()
  func reset()
}

protocol LoginUseCaseDelegate: class {

  func emailTextDidBecomeValid()
  func emailTextDidBecomeInvalid()

  func passwordTextDidBecomeValid()
  func passwordTextDidBecomeInvalid()

  func shouldEnableCallToAction()
  func shouldDisableCallToAction()

  func didStartLoginAttempt()
  func didSuccessfullyAuthenticate(user: AuthenticatedUser)
  func didFailToAuthenticateUserWithError(error: PresentableError)
}
