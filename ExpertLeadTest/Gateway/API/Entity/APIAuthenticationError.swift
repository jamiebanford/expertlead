import Foundation

/// The error passed by an unsuccessful authenticate call
struct APIAuthenticationError: Error {
  let message: String?
  let description: String?

  init(message: String? = nil, errorDescription: String? = nil) {
    self.message = message
    self.description = errorDescription
  }
}
