import Foundation

class SuccessPresenter {
    
    // MARK: - Properties
    weak var view: SuccessViewContract!
    var router: RouterContract
    
    // MARK: - Initializers
    init(view: SuccessViewContract, router: RouterContract) {
        self.view = view
        self.router = router
    }
}

extension SuccessPresenter: SuccessPresenterContract {
    
    func viewDidLoad() {
        // do something
    }
    
    func viewWillAppear() {
        // do something
    }
}
