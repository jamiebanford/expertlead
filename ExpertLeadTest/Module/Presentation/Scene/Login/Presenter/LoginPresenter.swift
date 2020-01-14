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

  func didSuccessFullyAuthenticate(user authenticatedUser: AuthenticatedUser) {
    print(authenticatedUser)
    // TODO: Do something with the authenticated user
    // Saving the token is probably a good idea...

    router.presentSuccess()
  }
}
