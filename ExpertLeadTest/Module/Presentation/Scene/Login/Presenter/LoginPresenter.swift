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

    // Set up the view
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
    useCase.authenticate(onSuccess: { authenticatedUser in
      print(authenticatedUser)
    }) { displayableError in
      print(displayableError)
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

  func updateLoginButton() {

    if useCase.hasValidCredentials {
      view.enableLoginButton()
    } else {
      view.disableLoginButton()
    }
  }
}
