import Foundation

protocol LoginPresenterContract: class {

  // MARK: - View life cycle

  func viewDidLoad()
  func viewWillAppear()

  // MARK: - View actions

  func update(emailText newEmailText: String)
  func update(passwordText newPasswordText: String)
  func callToActionPressed()
}
