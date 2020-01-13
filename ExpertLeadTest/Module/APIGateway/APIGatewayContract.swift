import Foundation

protocol APIGatewayContract {
  func authenticate(user: Credentials,
                    onSuccess: @escaping (_ response: SuccessfulAuthenticationResponse) -> (),
                    onFailure: @escaping (_ message: APIAuthenticationError) -> ())
}
