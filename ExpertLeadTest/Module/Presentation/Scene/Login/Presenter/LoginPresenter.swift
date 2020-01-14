import Foundation

class LoginPresenter {
  
  // MARK: - Public properties
  
  weak var view: LoginViewContract!
  var router: RouterContract

  let useCase: LoginUseCaseContract
  
  // MARK: - Initialisers
  
  init(view: LoginViewContract, router: RouterContract, useCase: LoginUseCaseContract) {
    self.view = view
    self.router = router
    self.useCase = useCase
  }
}

extension LoginPresenter: LoginPresenterContract {

  // MARK: - Life cycle
  
  func viewDidLoad() {

    setUpErrorMessageLabel()
    setUpActivityIndicator()
    updateLoginButton()
  }
  
  func viewWillAppear() {
    // do something
  }

  // MARK: - View actions

  func update(email newEmail: String) {
    save(email: newEmail)
    updateLoginButton()
  }

  func update(password newPassword: String) {
    save(password: newPassword)
    updateLoginButton()
  }

  func login() {

    prepareViewForLoginAttempt()

    useCase.authenticate(onSuccess: { authenticatedUser in
      print(authenticatedUser)
      self.updateViewAfterLoginAttempt()
    }) { displayableError in
      self.updateViewAfterLoginAttempt()
      self.display(errorMessage: displayableError.message)
    }
  }
}

// MARK: - Private helper methods

private extension LoginPresenter {

  func save(email newEmail: String) {

    useCase.currentEmail = newEmail
  }

  func save(password newPassword: String) {

    useCase.currentPassword = newPassword
  }

  func prepareViewForLoginAttempt() {
    view.showActivityIndicator()
    view.disableLoginButton()
    view.clearErrorMessage()
  }

  func updateViewAfterLoginAttempt() {
    view.hideActivityIndicator()
    view.enableLoginButton()
  }

  func setUpErrorMessageLabel() {
    view.clearErrorMessage()
  }

  func setUpActivityIndicator() {
    // Always animating and hides when stopped set in the storyboard so this should be all that is needed...
    view.hideActivityIndicator()
  }

  func updateLoginButton() {

    if useCase.hasValidCredentials {
      view.enableLoginButton()
    } else {
      view.disableLoginButton()
    }
  }

  func display(errorMessage: String) {
    view.update(errorMessage: errorMessage)
  }
}
