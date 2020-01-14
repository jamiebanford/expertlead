import Foundation

protocol LoginUseCaseContract: class {

  var apiGateway: APIGatewayContract { get }

  var currentEmail: String? { get set }
  var currentPassword: String? { get set }

  var hasValidCredentials: Bool { get }

  func authenticate(user: Credentials,
                    onSuccess: @escaping (_ response: AuthenticatedUser) -> (),
                    onFailure: @escaping (_ message: DisplayableError) -> ())
}
