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
    presenter.login()
  }

  // MARK: View actions

  func enableLoginButton() {
    DispatchQueue.main.async { [weak self] in
      self?.loginButton.isEnabled = true
    }
  }

  func disableLoginButton() {
    loginButton.isEnabled = false
  }

  func showActivityIndicator() {
    activityIndicatory.startAnimating()
  }

  func hideActivityIndicator() {
    DispatchQueue.main.async { [weak self] in
      self?.activityIndicatory.stopAnimating()
    }
  }

  func clearErrorMessage() {
    errorMessageLabel.text = nil
  }

  func update(errorMessage newErrorMessage: String) {
    DispatchQueue.main.async { [weak self] in
      self?.errorMessageLabel.text = newErrorMessage
    }
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
