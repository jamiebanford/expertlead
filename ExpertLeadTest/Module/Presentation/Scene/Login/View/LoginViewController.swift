import UIKit

class LoginViewController: UIViewController, LoginViewContract {

  // MARK: - IB Outlets

  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var activityIndicatory: UIActivityIndicatorView!
  @IBOutlet weak var errorMessageLabel: UILabel!

  var presenter: LoginPresenterContract!

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.viewWillAppear()
  }

  // MARK: - IB Actions

  @IBAction func buttonPressed(_ sender: Any) {
    presenter.loginButtonPressed()
  }

  // MARK: View actions

  func enableLoginButton() {
    loginButton.isEnabled = true
  }

  func disableLoginButton() {
    loginButton.isEnabled = false
  }

  func showActivityIndicator() {
    activityIndicatory.startAnimating()
  }

  func hideActivityIndicator() {
    activityIndicatory.stopAnimating()
  }

  func clearErrorMessage() {
    errorMessageLabel.text = nil
  }

  func update(errorMessage newErrorMessage: String) {
    errorMessageLabel.text = newErrorMessage
  }

  func setUpLoginButton() {
    loginButton.setTitle("Login", for: .normal)
    loginButton.setTitle("Login", for: .disabled)
  }

  func updateLoginButtonForRequestInProgress() {
    loginButton.setTitle("Cancel", for: .normal)
    loginButton.setTitle("Cancel", for: .disabled)
  }

  func updateLoginButtonForFailedRequest() {
    loginButton.setTitle("Try again", for: .normal)
    loginButton.setTitle("Try again", for: .disabled)
  }
}

// MARK: - Text field delegate

extension LoginViewController: UITextFieldDelegate {

  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {

    guard
      let existingText = textField.text,
      let rangeExpression = Range(range, in: existingText) else {
        return false
    }

    let currentText = existingText.replacingCharacters(in: rangeExpression, with: string)

    if textField == emailField {
      presenter.update(email: currentText)
    }

    if textField == passwordField {
      presenter.update(password: currentText)
    }

    return true
  }
}
