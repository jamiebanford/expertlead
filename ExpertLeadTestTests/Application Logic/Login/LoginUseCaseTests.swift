import XCTest

@testable
import ExpertLeadTest

class LoginUseCaseTests: XCTestCase {

  // MARK: - Object under test

  var loginUseCase: LoginUseCase!

  // MARK: - Mocks

  var loginUseCaseDelegate: MockLoginUseCaseDelegate!
  var apiGateway: MockAPIGateway!

  // MARK: - Set up and tear down

  override func setUp() {
    apiGateway = MockAPIGateway()
    loginUseCase = LoginUseCase(apiGateway: apiGateway)
    loginUseCaseDelegate = MockLoginUseCaseDelegate()

    loginUseCase.delegate = loginUseCaseDelegate
  }

  override func tearDown() {
    loginUseCase = nil
    loginUseCaseDelegate = nil
    apiGateway = nil
  }

  // MARK: - Email validation logic tests

  func testUpdatingEmailTextIniallyWithInvalidTextCausesTheCorrectDelegateMethodToBeCalled() {
    loginUseCase.update(emailText: "Invalid email text")

    XCTAssertTrue(loginUseCaseDelegate.hasEmailTextDidBecomeInvalidBeenCalled,
                  "Entering invalid email text should cause the email text become invalid delegate method to be called")
  }

  func testUpdatingEmailTextFromValidToInvalidTextCausesTheCorrectDelegateMethodToBeCalled() {
    loginUseCase.update(emailText: "valid@email.text")
    loginUseCase.update(emailText: "Invalid email text")

    XCTAssertTrue(loginUseCaseDelegate.hasEmailTextDidBecomeInvalidBeenCalled,
                  "Entering invalid email text should cause the email text become invalid delegate method to be called")
  }

  func testUpdatingEmailTextIniallyWithValidTextCausesTheCorrectDelegateMethodToBeCalled() {
    loginUseCase.update(emailText: "valid@email.text")

    XCTAssertTrue(loginUseCaseDelegate.hasEmailTextDidBecomeValidBeenCalled,
                  "Entering valid email text should cause the email text become valid delegate method to be called")
  }

  func testUpdatingEmailTextFromInvalidToValidTextCausesTheCorrectDelegateMethodToBeCalled() {
    loginUseCase.update(emailText: "Invalid email text")
    loginUseCase.update(emailText: "valid@email.text")

    XCTAssertTrue(loginUseCaseDelegate.hasEmailTextDidBecomeValidBeenCalled,
                  "Entering valid email text should cause the email text become valid delegate method to be called")
  }

  // MARK: - Password validation logic tests

  func testUpdatingPasswordTextIniallyWithInvalidTextCausesTheCorrectDelegateMethodToBeCalled() {
    loginUseCase.update(passwordText: "")

    XCTAssertTrue(loginUseCaseDelegate.hasPasswordTextDidBecomeInvalidBeenCalled,
                  "Entering invalid password text should cause the password text become invalid delegate method to be called")
  }

  func testUpdatingPasswordTextFromValidToInvalidTextCausesTheCorrectDelegateMethodToBeCalled() {
    loginUseCase.update(passwordText: "This is a valid password")
    loginUseCase.update(passwordText: "")

    XCTAssertTrue(loginUseCaseDelegate.hasPasswordTextDidBecomeInvalidBeenCalled,
                  "Entering invalid password text should cause the password text become invalid delegate method to be called")
  }

  func testUpdatingPasswordTextIniallyWithValidTextCausesTheCorrectDelegateMethodToBeCalled() {
    loginUseCase.update(passwordText: "This is a valid password")

    XCTAssertTrue(loginUseCaseDelegate.hasPasswordTextDidBecomeValidBeenCalled,
                  "Entering valid password text should cause the password text become valid delegate method to be called")
  }

  func testUpdatingPasswordTextFromInvalidToValidTextCausesTheCorrectDelegateMethodToBeCalled() {
    loginUseCase.update(passwordText: "")
    loginUseCase.update(passwordText: "This is a valid password")

    XCTAssertTrue(loginUseCaseDelegate.hasPasswordTextDidBecomeValidBeenCalled,
                  "Entering valid password text should cause the password text become valid delegate method to be called")
  }

  // MARK: - Call to action state tests

  func testUpdatingEmailTextToInvalidTextWhenPasswordTextIsAlreadyInvalidDoesNotCauseCTAToBeEnabledOrDisabled() {
    loginUseCase.update(emailText: "Invalid email text")

    XCTAssertFalse(loginUseCaseDelegate.hasShouldEnableCallToActionBeenCalled, "Delegate methods should not be called at the wrong time")
    XCTAssertFalse(loginUseCaseDelegate.hasShouldDisableCallToActionBeenCalled, "Delegate methods should not be called at the wrong time")
  }

  func testUpdatingEmailTextToValidTextWhenPasswordTextIsAlreadyInvalidDoesNotCauseCTAToBeEnabledOrDisabled() {
    loginUseCase.update(emailText: "valid@email.text")

    XCTAssertFalse(loginUseCaseDelegate.hasShouldEnableCallToActionBeenCalled, "Delegate methods should not be called at the wrong time")
    XCTAssertFalse(loginUseCaseDelegate.hasShouldDisableCallToActionBeenCalled, "Delegate methods should not be called at the wrong time")
  }

  func testUpdatingEmailTextToValidTextWhenPasswordTextIsAlreadyValidDoesCauseCTAToBeEnabled() {
    loginUseCase.update(passwordText: "This is a valid password")
    loginUseCase.update(emailText: "valid@email.text")

    XCTAssertTrue(loginUseCaseDelegate.hasShouldEnableCallToActionBeenCalled,
                  "Entering a valid email when when a valid password has already been entered should cause the enable CTA method to be called")
    XCTAssertFalse(loginUseCaseDelegate.hasShouldDisableCallToActionBeenCalled,
                   "Entering a valid email when when a valid password has already been entered should not cause the disable CTA method to be called")
  }

  func testUpdatingPasswordTextToValidTextWhenEmailTextIsAlreadyValidDoesCauseCTAToBeEnabled() {
    loginUseCase.update(emailText: "valid@email.text")
    loginUseCase.update(passwordText: "This is a valid password")

    XCTAssertTrue(loginUseCaseDelegate.hasShouldEnableCallToActionBeenCalled,
                  "Entering a valid password when when a valid email has already been entered should cause the enable CTA method to be called")
    XCTAssertFalse(loginUseCaseDelegate.hasShouldDisableCallToActionBeenCalled,
                   "Entering a valid password when when a valid email has already been entered should not cause the disable CTA method to be called")
  }

  // MARK: - Perform tests

  func testPerformAttemptsToLoginWhenValidEmailAndPasswordTextAreSet() {
    loginUseCase.update(emailText: "valid@email.text")
    loginUseCase.update(passwordText: "This is a valid password")

    loginUseCase.perform()

    XCTAssertTrue(apiGateway.isRequestCurrentlyInProgress, "Performing the use case should start an API request")
  }

  func testPerformNotifiesThePresenterThatALoginAttemptIsUnderway() {
    loginUseCase.update(emailText: "valid@email.text")
    loginUseCase.update(passwordText: "This is a valid password")

    loginUseCase.perform()

    XCTAssertTrue(loginUseCaseDelegate.hasDidStartLoginAttemptBeenCalled, "Performing the use case should call did start login attempt")
  }

  func testPerformAttemptsToCancelARequestWhichIsInProgress() {

    apiGateway.isRequestCurrentlyInProgress = true
    loginUseCase.perform()

    XCTAssertFalse(apiGateway.isRequestCurrentlyInProgress, "Performing the use case should cancel an API request that is currently underway")
  }
}
