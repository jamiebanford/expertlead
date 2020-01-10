import Foundation

struct APIAuthenticationError: Error {
  let message: String?
  let errorDescription: String?
  // TODO: Add the status code
  // let statusCode: Int

  init(message: String? = nil, errorDescription: String? = nil) {
    self.message = message
    self.errorDescription = errorDescription
  }
}
