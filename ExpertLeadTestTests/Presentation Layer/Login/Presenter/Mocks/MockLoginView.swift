import Foundation

@testable
import ExpertLeadTest

class MockLoginView: LoginViewContract {

  // MARK: - Test properties

  var hasSetUpBeenCalled = false
  var hasResetBeenCalled = false
  var hasUpdateEmailTextFieldForValidEmailTextBeenCalled = false
  var hasUpdateEmailTextFieldForInvalidEmailTextBeenCalled = false
  var hasUpdatePasswordTextFieldForValidPasswordTextBeenCalled = false
  var hasUpdatePasswordTextFieldForInvalidPasswordTextBeenCalled = false
  var hasShouldEnableCallToActionBeenCalled = false
  var hasShouldDisableCallToActionBeenCalled = false
  var hasUpdateForLoginAttemptBeenCalled = false
  var hasUpdateAfterSuccessfulLoginAttemptBeenCalled = false
  var hasUpdateAfterUnsuccessfulLoginAttemptBeenCalled = false

  // MARK: - Public API

  func setUp() {
    hasSetUpBeenCalled = true
  }

  func reset() {
    hasResetBeenCalled = true
  }

  func updateEmailTextFieldForValidEmailText() {
    hasUpdateEmailTextFieldForValidEmailTextBeenCalled = true
  }

  func updateEmailTextFieldForInvalidEmailText() {
    hasUpdateEmailTextFieldForInvalidEmailTextBeenCalled = true
  }

  func updatePasswordTextFieldForValidPasswordText() {
    hasUpdatePasswordTextFieldForValidPasswordTextBeenCalled = true
  }

  func updatePasswordTextFieldForInvalidPasswordText() {
    hasUpdatePasswordTextFieldForInvalidPasswordTextBeenCalled = true
  }

  func enableCallToAction() {
    hasShouldEnableCallToActionBeenCalled = true
  }

  func disableCallToAction() {
    hasShouldDisableCallToActionBeenCalled = true
  }

  func updateForLoginAttempt() {
    hasUpdateForLoginAttemptBeenCalled = true
  }

  func updateAfterSuccessfulLoginAttempt() {
    hasUpdateAfterSuccessfulLoginAttemptBeenCalled = true
  }

  func updateAfterUnsuccessfulLoginAttempt(with errorMessage: String) {
    hasUpdateAfterUnsuccessfulLoginAttemptBeenCalled = true
  }
}
