import Foundation

@testable
import ExpertLeadTest

class MockLoginUseCase: LoginUseCaseContract {

  // MARK: - Test properties

  var currentEmailText: String?
  var currentPasswordText: String?
  var hasPerformBeenCalled = false
  var hasResetBeenCalled = false

  // MARK: - Public API

  func update(emailText newEmailText: String) {
    currentEmailText = newEmailText
  }

  func update(passwordText newPasswordText: String) {
    currentPasswordText = newPasswordText
  }

  func perform() {
    hasPerformBeenCalled = true
  }

  func reset() {
    hasResetBeenCalled = true
  }
}
