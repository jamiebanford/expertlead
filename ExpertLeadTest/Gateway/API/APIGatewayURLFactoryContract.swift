import Foundation

protocol APIGatewayURLFactoryContract {

  func makeBaseURL() -> URL

  func makeAuthenticateURL() -> URL
}
