import Foundation

@testable
import ExpertLeadTest

class MockLoginUseCaseDelegate: LoginUseCaseDelegate {

  // MARK: - Test properties

  var hasEmailTextDidBecomeValidBeenCalled = false
  var hasEmailTextDidBecomeInvalidBeenCalled = false
  var hasPasswordTextDidBecomeValidBeenCalled = false
  var hasPasswordTextDidBecomeInvalidBeenCalled = false
  var hasShouldEnableCallToActionBeenCalled = false
  var hasShouldDisableCallToActionBeenCalled = false
  var hasDidStartLoginAttemptBeenCalled = false
  var hasDidSuccessfullyAuthenticateUserBeenCalled = true
  var hasDidFailToAuthenticateUserWithErrorBeenCalled = false

  // MARK: - Public API

  func emailTextDidBecomeValid() {
    hasEmailTextDidBecomeValidBeenCalled = true
  }

  func emailTextDidBecomeInvalid() {
    hasEmailTextDidBecomeInvalidBeenCalled = true
  }

  func passwordTextDidBecomeValid() {
    hasPasswordTextDidBecomeValidBeenCalled = true
  }

  func passwordTextDidBecomeInvalid() {
    hasPasswordTextDidBecomeInvalidBeenCalled = true
  }

  func shouldEnableCallToAction() {
    hasShouldEnableCallToActionBeenCalled = true
  }

  func shouldDisableCallToAction() {
    hasShouldDisableCallToActionBeenCalled = true
  }

  func didStartLoginAttempt() {
    hasDidStartLoginAttemptBeenCalled = true
  }

  func didSuccessfullyAuthenticate(user: AuthenticatedUser) {
    hasDidSuccessfullyAuthenticateUserBeenCalled = true
  }

  func didFailToAuthenticateUserWithError(error: PresentableError) {
    hasDidFailToAuthenticateUserWithErrorBeenCalled = true
  }
}
