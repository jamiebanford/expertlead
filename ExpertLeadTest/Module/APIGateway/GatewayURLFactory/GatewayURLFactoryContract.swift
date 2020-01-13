import Foundation

protocol GatewayURLFactoryContract {
  func makeBaseURL() -> URL
  func makeAuthenticateURL() -> URL
}
