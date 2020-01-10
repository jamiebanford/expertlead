import Foundation

class LoginPresenter {
  
  // MARK: - Properties
  
  weak var view: LoginViewContract!
  var router: RouterContract

  let interactor: LoginInteractorContract
  
  // MARK: - Initialisers
  
  init(view: LoginViewContract, router: RouterContract, interactor: LoginInteractorContract) {
    self.view = view
    self.router = router
    self.interactor = interactor
  }
}

extension LoginPresenter: LoginPresenterContract {

  
  func viewDidLoad() {
    // Test the /authenticate endpoint
    let user = Credentials(email: "user@test.com", password: "This1sATest!")
    interactor.authenticate(user: user, onSuccess: { authenticatedUser in
      print(authenticatedUser)
    }) { displayableError in
      print(displayableError)
    }

  }
  
  func viewWillAppear() {
    // do something
  }
}
