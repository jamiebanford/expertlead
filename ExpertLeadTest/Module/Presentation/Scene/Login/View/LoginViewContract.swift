import Foundation

protocol LoginViewContract: class {

  func enableLoginButton()
  func disableLoginButton()
  func updateLoginButtonForRequestInProgress()
  func updateLoginButtonForFailedRequest()

  func showActivityIndicator()
  func hideActivityIndicator()

  func clearErrorMessage()
  func update(errorMessage newErrorMessage: String)
}
