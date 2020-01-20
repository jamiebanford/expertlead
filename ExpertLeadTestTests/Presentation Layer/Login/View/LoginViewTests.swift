import XCTest

@testable
import ExpertLeadTest

class LoginViewTests: XCTestCase {

  // MARK: - Object under test

  var loginView: LoginViewController!

  // MARK: Mocks
  var presenter: LoginPresenterMock!

  // MARK: - Set up and tear down

  override func setUp() {
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let view = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController

    presenter = LoginPresenterMock()
    view.presenter = presenter

    loginView = view
    loginView.loadView()
  }

  override func tearDown() {
    loginView = nil
    presenter = nil
  }

  // MARK: - Email text field tests

  func testEmailTextFieldIsCorrectlyDesignedAfterSetUp() {
    loginView.setUp()

    XCTAssertEqual(loginView.emailTextField.layer.borderWidth, 1, "The email text field should have the correct border width")
    XCTAssertEqual(loginView.emailTextField.layer.cornerRadius, 5, "The email text field should have the correct corner radius")
  }

  func testEmailTextFieldIsCorrectlyDesignedAfterReset() {
    loginView.reset()

    XCTAssertEqual(loginView.emailTextField.layer.borderColor, UIColor.black.cgColor, "The email text field should have the correct border colour")
  }

  func testValidEmailTextFeedbackIsCorrect() {
    loginView.updateEmailTextFieldForValidEmailText()

    XCTAssertEqual(loginView.emailTextField.layer.borderColor, UIColor.blue.cgColor, "The email text field should have the correct border colour")
  }

  func testInvalidEmailTextFeedbackIsCorrect() {
    loginView.updateEmailTextFieldForInvalidEmailText()

    XCTAssertEqual(loginView.emailTextField.layer.borderColor, UIColor.red.cgColor, "The email text field should have the correct border colour")
  }

  func testEmailTextFieldIsSetUpCorrectly() {
    loginView.setUp()

    XCTAssertTrue(loginView.emailTextField.text!.isEmpty, "The email text field should be set up with an empty string")
    XCTAssertEqual(loginView.emailTextField.placeholder, "Email", "The email text field should be set up with the correct placeholder")
    XCTAssertEqual(loginView.emailTextField.keyboardType, .emailAddress, "The email text field should be set up with the correct keyboard type")
  }

  func testEmailTextChangesArePassedToThePresenter() {
    loginView.setUp()

    let textField = loginView.emailTextField!
    let range = NSMakeRange(0, 0)
    let _ = loginView.textField(textField, shouldChangeCharactersIn: range, replacementString: "New email text")

    XCTAssertTrue(presenter.currentEmailText == "New email text")
  }

  // MARK: - Password text field tests

  func testPasswordTextFieldIsCorrectlyDesignedAfterSetUp() {
    loginView.setUp()

    XCTAssertEqual(loginView.passwordTextField.layer.borderWidth, 1, "The password text field should have the correct border width")
    XCTAssertEqual(loginView.passwordTextField.layer.cornerRadius, 5, "The password text field should have the correct corner radius")
  }

  func testPasswordTextFieldIsCorrectlyDesignedAfterReset() {
    loginView.reset()

    XCTAssertEqual(loginView.passwordTextField.layer.borderColor, UIColor.black.cgColor, "The password text field should have the correct border colour")
  }

  func testValidPasswordTextFeedbackIsCorrect() {
    loginView.updatePasswordTextFieldForValidPasswordText()

    XCTAssertEqual(loginView.passwordTextField.layer.borderColor, UIColor.blue.cgColor, "The password text field should have the correct border colour")
  }

  func testInvalidPasswordTextFeedbackIsCorrect() {
    loginView.updatePasswordTextFieldForInvalidPasswordText()

    XCTAssertEqual(loginView.passwordTextField.layer.borderColor, UIColor.red.cgColor, "The password text field should have the correct border colour")
  }

  func testPasswordTextFieldIsSetUpCorrectly() {
    loginView.setUp()

    XCTAssertTrue(loginView.passwordTextField.text!.isEmpty, "The password text field should be set up with an empty string")
    XCTAssertEqual(loginView.passwordTextField.placeholder, "Password", "The password text field should be set up with the correct placeholder")
    XCTAssertTrue(loginView.passwordTextField.isSecureTextEntry, "The password text field should be set up with secure text entry")
  }

  func testPasswordTextChangesArePassedToThePresenter() {
    loginView.setUp()

    let textField = loginView.passwordTextField!
    let range = NSMakeRange(0, 0)
    let _ = loginView.textField(textField, shouldChangeCharactersIn: range, replacementString: "New password text")

    XCTAssertTrue(presenter.currentPasswordText == "New password text")
  }

  // MARK: - Call to action tests

  func testCallToActionIsSetUpCorrectly() {
    loginView.setUp()

    XCTAssertEqual(loginView.callToAction.titleLabel!.text, "Login", "The call to action should be set up with the correct title")
    XCTAssertFalse(loginView.callToAction.isEnabled, "The call to action should be disabled set up")
  }

  func testCallToActionHasCorrectTitleWhenEnabled() {
    loginView.setUp()
    loginView.callToAction.isEnabled = true

    XCTAssertEqual(loginView.callToAction.titleLabel!.text, "Login", "The call to action should be set up with the correct title")
  }

  func testCallToActionPressesAreForwardedToThePresenter() {
    loginView.callToActionPressed(UIButton())

    XCTAssertTrue(presenter.hasCallToActionPressedBeenCalled, "Call to action presses should be forwarded to the presenter")
  }

  func testCallToActionIsEnabledCorrectly() {
    loginView.enableCallToAction()

    XCTAssertTrue(loginView.callToAction.isEnabled, "The call to action should be enabled")
  }

  func testCallToActionIsDisabledCorrectly() {
    loginView.disableCallToAction()

    XCTAssertFalse(loginView.callToAction.isEnabled, "The call to action should be disabled")
  }

  func testCallToActionUpdatesCorrectlyWhenLoginAttemptIsUnderway() {
    loginView.setUp()
    loginView.updateForLoginAttempt()

    XCTAssertEqual(loginView.callToAction.titleLabel?.text, "Cancel", "The call to action should have the correct label when a login attempt is underway")
  }

  // MARK: - Activity indicator tests

  func testActivityIndicatorIsSetUpCorrectly() {
    loginView.setUp()

    XCTAssertTrue(loginView.activityIndicator.isHidden, "The activity indicator should be hidden when set up")
  }

  func testActivityIndicatorIsShownWhenStarted() {
    loginView.setUp()
    loginView.activityIndicator.startAnimating()

    XCTAssertFalse(loginView.activityIndicator.isHidden, "The activity indicator should be shown when animating" )
  }

  func testActivityIndicatorUpdatesCorrectlyWhenLoginAttemptIsUnderway() {
    loginView.setUp()
    loginView.updateForLoginAttempt()

    XCTAssertFalse(loginView.activityIndicator.isHidden, "The activity indicator not be hidden when a login attempt is underway")
    XCTAssertTrue(loginView.activityIndicator.isAnimating, "The activity indicator should she be animating when a login attempt is underway")
  }

  func testActivityIndicatorIsHiddenAfterSuccessfulLogin() {
    loginView.setUp()
    loginView.updateAfterSuccessfulLoginAttempt()

    XCTAssertTrue(loginView.activityIndicator.isHidden, "The activity indicatory should be hidden when authentication was successful")
  }

  func testActivityIndicatorIsHiddenAfterUnsuccessfulLogin() {
    loginView.setUp()
    loginView.updateAfterUnsuccessfulLoginAttempt(with: "Error message")

    XCTAssertTrue(loginView.activityIndicator.isHidden, "The activity indicatory should be hidden when an error message is shown")
  }

  // MARK: - Error message label tests

  func testErrorMessageLabelIsSetUpCorrectly() {
    loginView.setUp()

    XCTAssertTrue(loginView.errorMessageLabel.text!.isEmpty, "The error message label should be set up with an empty string")
  }

  func testErrorMessageLabelUpdatesCorrectlyWhenLoginAttemptIsUnderway() {
    loginView.setUp()
    loginView.updateForLoginAttempt()

    XCTAssertTrue(loginView.errorMessageLabel.text!.isEmpty, "The error message label should be an empty string when a login attempt is underway")

  }

  func testErrorMessagesAreDisplayedCorrectly() {
    loginView.setUp()
    loginView.updateAfterUnsuccessfulLoginAttempt(with: "Error message")

    XCTAssertEqual(loginView.errorMessageLabel.text, "Error message",  "The error message label display the correct error message")
    XCTAssertEqual(loginView.callToAction.titleLabel?.text, "Try again", "The call to action title should show the correct text after an error is shown")
  }
}
