import Foundation

/// The user credentials to be authenticated
struct Credentials: Codable {
  let email: String
  let password: String
}
