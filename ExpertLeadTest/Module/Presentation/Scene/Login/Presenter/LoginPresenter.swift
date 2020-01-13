import Foundation

class LoginPresenter {
  
  // MARK: - Properties
  
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
}
