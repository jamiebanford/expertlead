import Foundation

struct APIAuthenticationError: Error {
  let message: String?
  let errorDescription: String?

  init(message: String? = nil, errorDescription: String? = nil) {
    self.message = message
    self.errorDescription = errorDescription
  }
}
