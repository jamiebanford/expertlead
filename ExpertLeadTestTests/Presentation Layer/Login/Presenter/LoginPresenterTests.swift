import XCTest

@testable
import ExpertLeadTest

class LoginPresenterTests: XCTestCase {

  // MARK: - Object under test

  var loginPresenter: LoginPresenter!

  // MARK: - Mocks

  var loginView: MockLoginView!
  var useCase: MockLoginUseCase!
  var router: MockRouter!

  // MARK: - Set up and tear down

  override func setUp() {
    loginView = MockLoginView()
    useCase = MockLoginUseCase()
    router = MockRouter()

    loginPresenter = LoginPresenter(view: loginView,
                                    useCase: useCase,
                                    router: router)
  }

  override func tearDown() {
    loginPresenter = nil

    loginView = nil
    useCase = nil
    router = nil
  }

  // MARK: - View life cycle tests

  func testSetUpCalledOnViewWhenViewDidLoadCalled() {
    loginPresenter.viewDidLoad()

    XCTAssertTrue(loginView.hasSetUpBeenCalled, "The setUp method should be called on the View")
  }

  func testResetCalledOnViewWhenViewWillAppearCalled() {
    loginPresenter.viewWillAppear()

    XCTAssertTrue(loginView.hasResetBeenCalled, "The reset method should be called on the View")
  }

  // MARK: - View action tests

  func testUpdatedEmailTextIsPassedToTheUseCase() {
    loginPresenter.update(emailText: "New email text")

    XCTAssertEqual(useCase.currentEmailText, "New email text", "The new email text should be passed to the use case")
  }

  func testUpdatedPasswordTextIsPassedToTheUseCase() {
    loginPresenter.update(passwordText: "New password text")

    XCTAssertEqual(useCase.currentPasswordText, "New password text", "The new password text should be passed to the use case")
  }

  func testCallToActionIsPassedToUseCase() {
    loginPresenter.callToActionPressed()

    XCTAssertTrue(useCase.hasPerformBeenCalled, "Pressing the call to action should cause the use case to be performed")
  }

  // MARK: - Use case delegate call tests

  func testEmailTextDidBecomeValidUpdatesView() {
    loginPresenter.emailTextDidBecomeValid()

    XCTAssertTrue(loginView.hasUpdateEmailTextFieldForValidEmailTextBeenCalled, "Update email text for valid email should be called")
  }

  func testEmailTextDidBecomeInvalidUpdatesView() {
    loginPresenter.emailTextDidBecomeInvalid()

    XCTAssertTrue(loginView.hasUpdateEmailTextFieldForInvalidEmailTextBeenCalled, "Update email text for invalid email should be called")
  }

  func testPasswordTextDidBecomeValidUpdatesView() {
    loginPresenter.passwordTextDidBecomeValid()

    XCTAssertTrue(loginView.hasUpdatePasswordTextFieldForValidPasswordTextBeenCalled, "Update password text for valid password should be called")
  }

  func testPasswordTextDidBecomeInvalidUpdatesView() {
    loginPresenter.passwordTextDidBecomeInvalid()

    XCTAssertTrue(loginView.hasUpdatePasswordTextFieldForInvalidPasswordTextBeenCalled, "Update password text for invalid password should be called")
  }

  func testShouldEnableCallToActionUpdatesView() {
    loginPresenter.shouldEnableCallToAction()

    XCTAssertTrue(loginView.hasShouldEnableCallToActionBeenCalled, "Should enable call to action should be called")
  }

  func testShouldDisableCallToActionUpdatesView() {
    loginPresenter.shouldDisableCallToAction()

    XCTAssertTrue(loginView.hasShouldDisableCallToActionBeenCalled, "Should disable call to action should be called")
  }

  func testDidStartLoginAttemptUpdatesView() {
    loginPresenter.didStartLoginAttempt()

    XCTAssertTrue(loginView.hasUpdateForLoginAttemptBeenCalled, "Update for login attempt should be called")
  }

  func testDidSuccessfullyAuthenticateUserUpdatesView() {
    let user = AuthenticatedUser(email: "email@host.com", token: "42")
    loginPresenter.didSuccessfullyAuthenticate(user: user)

    XCTAssertTrue(loginView.hasUpdateAfterSuccessfulLoginAttemptBeenCalled, "Update after successful login attempt should be called")
  }

  func testDidFailToAuthenticateUserWithErrorUpdatesView() {
    let error = PresentableError(message: nil)
    loginPresenter.didFailToAuthenticateUserWithError(error: error)

    XCTAssertTrue(loginView.hasUpdateAfterUnsuccessfulLoginAttemptBeenCalled, "Update after Unsuccessful login attempt should be called")
  }
}
