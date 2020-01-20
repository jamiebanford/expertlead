import Foundation
import os.log

class LoginPresenter {

  // MARK: - Properties

  let useCase: LoginUseCaseContract

  weak var view: LoginViewContract!
  var router: RouterContract

  // MARK: - Initialisers

  init(view: LoginViewContract,
       useCase: LoginUseCaseContract,
       router: RouterContract) {

    self.view = view
    self.useCase = useCase
    self.router = router
  }
}

extension LoginPresenter: LoginPresenterContract {

  // MARK: - View life cycle

  func viewDidLoad() {
    view.setUp()
  }

  func viewWillAppear() {
    view.reset()
  }

  // MARK: - View actions

  func update(emailText newEmailText: String) {
    useCase.update(emailText: newEmailText)
  }

  func update(passwordText newPasswordText: String) {
    useCase.update(passwordText: newPasswordText)
  }

  func callToActionPressed() {
    useCase.perform()
  }
}

// MARK: - Login use case delegate

extension LoginPresenter: LoginUseCaseDelegate {
  func emailTextDidBecomeValid() {
    view.updateEmailTextFieldForValidEmailText()
  }

  func emailTextDidBecomeInvalid() {
    view.updateEmailTextFieldForInvalidEmailText()
  }

  func passwordTextDidBecomeValid() {
    view.updatePasswordTextFieldForValidPasswordText()
  }

  func passwordTextDidBecomeInvalid() {
    view.updatePasswordTextFieldForInvalidPasswordText()
  }

  func shouldEnableCallToAction() {
    view.enableCallToAction()
  }

  func shouldDisableCallToAction() {
    view.disableCallToAction()
  }

  func didStartLoginAttempt() {
    view.updateForLoginAttempt()
  }

  func didSuccessfullyAuthenticate(user: AuthenticatedUser) {
    os_log("Authenticated user %@ with token %@", type: .info, user.email, user.token)

    view.updateAfterSuccessfulLoginAttempt()
    router.presentSuccess()
    useCase.reset()
  }

  func didFailToAuthenticateUserWithError(error: PresentableError) {
    let errorMessage = error.message ?? error.genericMessage
    view.updateAfterUnsuccessfulLoginAttempt(with: errorMessage)
  }
}
