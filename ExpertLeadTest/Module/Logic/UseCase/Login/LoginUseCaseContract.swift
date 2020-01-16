import Foundation

protocol LoginUseCaseContract: class {

  var apiGateway: APIGatewayContract { get }

  var hasValidCredentials: (validEmail: Bool, validPassword: Bool) { get }
  var isLoginAttemptInProgress: Bool { get set }

  func update(email newEmail: String)
  func update(password newPassword: String)

  func authenticate(onSuccess: @escaping (_ response: AuthenticatedUser) -> (),
                    onFailure: @escaping (_ message: DisplayableError) -> ())

  func cancelAuthenticationRequest()
}
