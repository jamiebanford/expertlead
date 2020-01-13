import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  private var router: RouterContract!

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    // Start the flow
    window = UIWindow(frame: UIScreen.main.bounds)
    router = Router(window: window!, apiGateway: makeAPIGateway())
    router.presentLogin()
    window?.makeKeyAndVisible()

    return true
  }
}

// MARK: - Private factory methods

private extension AppDelegate {
  func makeAPIGateway() -> TinyNetworkingAPIGateway {

    return TinyNetworkingAPIGateway(urlFactory: GatewayURLFactory())
  }
}
