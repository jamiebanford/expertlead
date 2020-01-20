import Foundation

@testable
import ExpertLeadTest

class MockAPIGateway: APIGatewayContract {
  var isRequestCurrentlyInProgress = false

  func authenticate(credentials: Credentials,
                    onSuccess: @escaping (SuccessfulAuthenticationResponse) -> (),
                    onFailure: @escaping (APIAuthenticationError) -> ()) {

    isRequestCurrentlyInProgress = true
  }

  func cancelCurrentRequest() {
    isRequestCurrentlyInProgress = false
  }
}
