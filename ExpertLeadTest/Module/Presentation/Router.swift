import UIKit

protocol RouterContract {
  func presentLogin()
  func presentSuccess()
}

class Router {

  // MARK: - Properties

  private let apiGateway: APIGatewayContract
  private weak var window: UIWindow?
  private var mainStoryboard: UIStoryboard {
    return UIStoryboard(name: "Main", bundle: nil)
  }

  // MARK: - Initialisers

  init(window: UIWindow, apiGateway: APIGatewayContract) {
    self.window = window
    self.apiGateway = apiGateway
  }
}

extension Router: RouterContract {

  func presentLogin() {
    guard
      let navigationController = mainStoryboard.instantiateInitialViewController() as? UINavigationController,
      let view = navigationController.viewControllers.first as? LoginViewController
      else { return }

    let useCase = LoginUseCase(apiGateway: apiGateway)
    let presenter = LoginPresenter(view: view, router: self, useCase: useCase)
    view.presenter = presenter

    window?.rootViewController = navigationController
  }

  func presentSuccess() {
    let view = mainStoryboard.instantiateViewController(withIdentifier: "SuccessViewController") as! SuccessViewController

    let presenter = SuccessPresenter(view: view, router: self)
    view.presenter = presenter

    window?.rootViewController?.show(view, sender: nil)
  }
}
