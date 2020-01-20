import Foundation

protocol LoginViewContract: class {

  func setUp()
  func reset()

  func updateEmailTextFieldForValidEmailText()
  func updateEmailTextFieldForInvalidEmailText()

  func updatePasswordTextFieldForValidPasswordText()
  func updatePasswordTextFieldForInvalidPasswordText()

  func enableCallToAction()
  func disableCallToAction()

  func updateForLoginAttempt()
  func updateAfterSuccessfulLoginAttempt()
  func updateAfterUnsuccessfulLoginAttempt(with errorMessage: String)
}
