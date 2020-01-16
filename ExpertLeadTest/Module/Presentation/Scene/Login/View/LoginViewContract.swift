import Foundation

protocol LoginViewContract: class {

  func setUpEmailField()
  func setUpPasswordField()
  func updateEmailFieldForValidEmail()
  func updateEmailFieldForInvalidEmail()
  func updatePasswordFieldForValidPassword()
  func updatePasswordFieldForInvalidPassword()
  func enableLoginButton()
  func disableLoginButton()
  func setUpLoginButton()
  func updateLoginButtonForRequestInProgress()
  func updateLoginButtonForFailedRequest()

  func showActivityIndicator()
  func hideActivityIndicator()

  func clearErrorMessage()
  func update(errorMessage newErrorMessage: String)
}
