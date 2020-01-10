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
    let view = mainStoryboard.instantiateInitialViewController() as! LoginViewController
    let interactor = LoginInteractor(apiGateway: apiGateway)
    let presenter = LoginPresenter(view: view, router: self, interactor: interactor)
    view.presenter = presenter

    window?.rootViewController = view
  }

  func presentSuccess() {
    let view = mainStoryboard.instantiateViewController(withIdentifier: "SuccessViewController") as! SuccessViewController
    let presenter = SuccessPresenter(view: view, router: self)
    view.presenter = presenter

    window?.rootViewController?.present(view, animated: true)
  }
}
