import Foundation

protocol LoginViewContract: class {

  func enableLoginButton()
  func disableLoginButton()

  func showActivityIndicator()
  func hideActivityIndicator()

  func update(errorMessage newErrorMessage: String)
}
