import Foundation

import TinyNetworking

class TinyNetworkingEndpointFactory {

  func makeEndpointToAuthenticate(credentials: Credentials) -> Endpoint<AuthenticationResponse> {

    let url = APIGatewayURLFactory().makeAuthenticateURL()
    let endpoint = Endpoint<AuthenticationResponse>(json: .post,
                                                    url: url,
                                                    body: credentials,
                                                    expectedStatusCode: { code in
                                                      return code == 200 || code == 401 || code == 500
    })

    return endpoint
  }
}
