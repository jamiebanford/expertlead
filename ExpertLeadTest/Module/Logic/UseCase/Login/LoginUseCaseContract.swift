import Foundation

protocol LoginUseCaseContract: class {

  var apiGateway: APIGatewayContract { get }

  func validate(email newEmail: String) -> Bool

  func authenticate(user: Credentials,
                    onSuccess: @escaping (_ response: AuthenticatedUser) -> (),
                    onFailure: @escaping (_ message: DisplayableError) -> ())
}
