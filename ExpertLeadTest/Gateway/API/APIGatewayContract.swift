import Foundation

protocol APIGatewayContract {

  var isRequestCurrentlyInProgress: Bool { get }

  func authenticate(credentials: Credentials,
                    onSuccess: @escaping (_ response: SuccessfulAuthenticationResponse) -> (),
                    onFailure: @escaping (_ message: APIAuthenticationError) -> ())

  func cancelCurrentRequest()
}
