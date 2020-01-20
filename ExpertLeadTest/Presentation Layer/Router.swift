import UIKit

class Router {

  // MARK: - Properties

  private weak var window: UIWindow?
  private var mainStoryboard: UIStoryboard {
    return UIStoryboard(name: "Main", bundle: nil)
  }

  // MARK: - Initialisers

  init(window: UIWindow) {
    self.window = window
  }
}

extension Router: RouterContract {

  func presentLogin() {
    guard
      let navigationController = mainStoryboard.instantiateInitialViewController() as? UINavigationController,
      let view = navigationController.viewControllers.first as? LoginViewController
      else { preconditionFailure("Unable to create initial view from storyboard") }

    let apiGateway = TinyNetworkingAPIGateway()
    let useCase = LoginUseCase(apiGateway: apiGateway)
    let presenter = LoginPresenter(view: view,
                                   useCase: useCase,
                                   router: self)
    useCase.delegate = presenter
    view.presenter = presenter

    window?.rootViewController = navigationController
  }

  func presentSuccess() {
    guard
      let view = mainStoryboard.instantiateViewController(withIdentifier: "SuccessViewController") as? SuccessViewController
      else { preconditionFailure("Unable to create success view from storyboard") }

    let presenter = SuccessPresenter(view: view, router: self)
    view.presenter = presenter

    window?.rootViewController?.show(view, sender: self)
  }
}
