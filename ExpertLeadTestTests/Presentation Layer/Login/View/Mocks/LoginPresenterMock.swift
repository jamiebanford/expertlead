import Foundation

@testable
import ExpertLeadTest

class LoginPresenterMock: LoginPresenterContract {

  // MARK: - Test properties

  var currentEmailText = ""
  var currentPasswordText = ""
  var hasCallToActionPressedBeenCalled = false

  // MARK: - View life cycle

  func viewDidLoad() {
    // Stub
  }

  func viewWillAppear() {
    // Stub
  }

  // MARK: - View actions

  func update(emailText newEmailText: String) {
    currentEmailText = newEmailText
  }

  func update(passwordText newPasswordText: String) {
    currentPasswordText = newPasswordText
  }

  func callToActionPressed() {
    hasCallToActionPressedBeenCalled = true
  }
}
