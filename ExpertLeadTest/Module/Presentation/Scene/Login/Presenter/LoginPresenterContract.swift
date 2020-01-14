import Foundation

protocol LoginPresenterContract: class {
  var useCase: LoginUseCaseContract { get }

  // MARK: - Life cycle

  func viewDidLoad()
  func viewWillAppear()

  // MARK: View actions

  func update(email newEmail: String)
  func update(password newPassword: String)

  func login()
}
