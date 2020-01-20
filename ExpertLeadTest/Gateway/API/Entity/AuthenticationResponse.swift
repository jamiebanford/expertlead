import Foundation

/// The response of the authenticate call. Successfully authenticated users will receive a token.
struct AuthenticationResponse: Codable {
  let token: String?
  let message: String
}
