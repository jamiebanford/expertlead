import Foundation

protocol APIGatewayContract {
  func authenticate(credentials: Credentials,
                    onSuccess: @escaping (_ response: SuccessfulAuthenticationResponse) -> (),
                    onFailure: @escaping (_ message: APIAuthenticationError) -> ())

  func cancelCurrentRequest()
}
