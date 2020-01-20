import Foundation

/// The response of a successful authenticate call
struct SuccessfulAuthenticationResponse: Codable {
  let token: String
  let message: String
}
