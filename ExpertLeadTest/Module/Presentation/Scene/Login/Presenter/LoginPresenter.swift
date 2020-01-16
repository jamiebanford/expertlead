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
    setUpView()
  }
  
  func viewWillAppear() {
    setUpView()
  }

  // MARK: - View actions

  func update(email newEmail: String) {
    save(email: newEmail)
  }

  func update(password newPassword: String) {
    save(password: newPassword)
  }

  func loginButtonPressed() {

    if useCase.isLoginAttemptInProgress {
      // TODO: cancel the attempt
      cancel()
    } else {
      login()
    }
  }
}

// MARK: - Private helper methods

private extension LoginPresenter {

  func save(email newEmail: String) {

    useCase.update(email: newEmail)

    updateEmailFieldAfterEmailTextEntry()
    updateLoginButtonAfterTextEntry()
  }

  func save(password newPassword: String) {

    useCase.update(password: newPassword)

    updatePasswordFieldAfterPasswordTextEntry()
    updateLoginButtonAfterTextEntry()
  }

  func prepareViewForLoginAttempt() {
    view.showActivityIndicator()
    view.clearErrorMessage()
    view.updateLoginButtonForRequestInProgress()
  }

  func updateViewAfterSuccessfulLoginAttempt() {
    view.hideActivityIndicator()
  }

  func updateViewAfterFailedLoginAttempt() {
    view.hideActivityIndicator()
    view.updateLoginButtonForFailedRequest()
  }

  func setUpEmailTextField() {
    view.setUpEmailField()
  }

  func setUpPasswordTextField() {
    view.setUpPasswordField()
  }

  func setUpErrorMessageLabel() {
    view.clearErrorMessage()
  }

  func setUpActivityIndicator() {
    // Always animating and hides when stopped set in the storyboard so this should be all that is needed...
    view.hideActivityIndicator()
  }

  func updateEmailFieldAfterEmailTextEntry() {

    let (validEmail, _) = useCase.hasValidCredentials

    if validEmail {
      view.updateEmailFieldForValidEmail()
    } else {
      view.updateEmailFieldForInvalidEmail()
    }
  }

  func updatePasswordFieldAfterPasswordTextEntry() {

    let (_, validPassword) = useCase.hasValidCredentials

    if validPassword {
      view.updatePasswordFieldForValidPassword()
    } else {
      view.updatePasswordFieldForInvalidPassword()
    }
  }

  func updateLoginButtonAfterTextEntry() {

    let (validEmail, validPassword) = useCase.hasValidCredentials

    switch (validEmail, validPassword) {
      case (true, true):
        view.enableLoginButton()
      default:
        view.disableLoginButton()
    }
  }

  func setUpView() {
    setUpEmailTextField()
    setUpPasswordTextField()
    setUpErrorMessageLabel()
    setUpActivityIndicator()
    setUpLoginButton()
  }

  func setUpLoginButton() {
    view.setUpLoginButton()
  }

  func display(errorMessage: String) {
    view.update(errorMessage: errorMessage)
  }

  func didSuccessFullyAuthenticate(user authenticatedUser: AuthenticatedUser) {
    print(authenticatedUser)
    // TODO: Do something with the authenticated user
    // Saving the token is probably a good idea...

    view.resignFirstResponder()
    router.presentSuccess()
  }

  func login() {
    prepareViewForLoginAttempt()

    useCase.authenticate(onSuccess: { authenticatedUser in

      DispatchQueue.main.async { [weak self] in
        self?.updateViewAfterSuccessfulLoginAttempt()
        self?.didSuccessFullyAuthenticate(user: authenticatedUser)
      }

    }, onFailure: { displayableError in

      DispatchQueue.main.async { [weak self] in
        self?.updateViewAfterFailedLoginAttempt()
        self?.display(errorMessage: displayableError.message)
      }
    })
  }

  func cancel() {
    useCase.cancelAuthenticationRequest()
  }
}
