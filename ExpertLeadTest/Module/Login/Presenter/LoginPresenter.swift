import Foundation

class LoginPresenter {
    
    // MARK: - Properties
    weak var view: LoginViewContract!
    var router: RouterContract
    
    // MARK: - Initializers
    init(view: LoginViewContract, router: RouterContract) {
        self.view = view
        self.router = router
    }
}

extension LoginPresenter: LoginPresenterContract {
    
    func viewDidLoad() {
        // do something
    }
    
    func viewWillAppear() {
        // do something
    }
}
