import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  private var router: RouterContract!

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    // Start the flow
    window = UIWindow(frame: UIScreen.main.bounds)
    router = Router(window: window!, apiGateway: makeTestAPIGateway())
    router.presentLogin()
    window?.makeKeyAndVisible()

    return true
  }
}

// MARK: - Private factory methods

private extension AppDelegate {
  func makeTestAPIGateway() -> TinyNetworkingAPIGateway {
    // TODO: Create URLs in a URL factory class
    // FIXME: This URL should have the /test component
    guard let baseURL = URL(string: "https://p0jtvgfrj3.execute-api.eu-central-1.amazonaws.com/") else {
      preconditionFailure("Precondition failure: unable to create base URL")
    }

    return TinyNetworkingAPIGateway(baseURL: baseURL)
  }
}
