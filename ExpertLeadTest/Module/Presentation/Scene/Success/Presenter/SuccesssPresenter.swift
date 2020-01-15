import Foundation

class SuccessPresenter {

  // MARK: - Properties

  weak var view: SuccessViewContract!
  var router: RouterContract

  // MARK: - Initialisers

  init(view: SuccessViewContract, router: RouterContract) {
    self.view = view
    self.router = router
  }
}

extension SuccessPresenter: SuccessPresenterContract {

  func viewDidLoad() {
    view.setUp()
  }

  func viewWillAppear() {
    // do something
  }
}
