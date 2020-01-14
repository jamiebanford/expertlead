import Foundation

class LoginPresenter {
  
  // MARK: - Public properties
  
  weak var view: LoginViewContract!
  var router: RouterContract

  let useCase: LoginUseCaseContract

  // MARK: - Private properties

  var currentEmail: String?
  var currentPassword: String?
  
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
    // Test the /authenticate endpoint
    let user = Credentials(email: "user@test.com", password: "This1sATest!")
    useCase.authenticate(user: user, onSuccess: { authenticatedUser in
      print(authenticatedUser)
    }) { displayableError in
      print(displayableError)
    }

  }
  
  func viewWillAppear() {
    // do something
  }

  // MARK: - View actions

  func update(email newEmail: String) {
    if useCase.validate(email: newEmail) {
      currentEmail = newEmail
    } else {
      currentEmail = nil
    }
  }

  func update(password newPassword: String) {
    currentPassword = newPassword
  }
}
