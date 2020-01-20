import UIKit

class LoginViewController: UIViewController {

  // MARK: - IBOutlets

  @IBOutlet var emailTextField: UITextField!
  @IBOutlet var passwordTextField: UITextField!
  @IBOutlet var callToAction: UIButton!
  @IBOutlet var activityIndicator: UIActivityIndicatorView!
  @IBOutlet var errorMessageLabel: UILabel!

  // MARK: - IBActions

  @IBAction func callToActionPressed(_ sender: UIButton) {
    presenter.callToActionPressed()
  }

  // MARK: - Properties

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
}

// MARK: - Public API

extension LoginViewController: LoginViewContract {

  func setUp() {
    designEmailTextField()
    designPasswordTextField()

    setUpEmailTextField()
    setUpPasswordTextField()
    setUpCallToAction()
    setUpActivityIndicator()
    setUpErrorMessageLabel()
  }

  func reset() {
    designEmailTextFieldForInitialState()
    designPasswordTextFieldForInitialState()

    resetEmailTextField()
    resetPasswordTextField()
    setUpCallToAction()
    setUpActivityIndicator()
    setUpErrorMessageLabel()
  }

  func updateEmailTextFieldForValidEmailText() {
    designEmailTextFieldForValidState()
  }

  func updateEmailTextFieldForInvalidEmailText() {
    designEmailTextFieldForInvalidState()
  }

  func updatePasswordTextFieldForValidPasswordText() {
    designPasswordTextFieldForValidState()
  }

  func updatePasswordTextFieldForInvalidPasswordText() {
    designPasswordTextFieldForInvalidState()
  }

  func enableCallToAction() {
    callToAction.isEnabled = true
  }

  func disableCallToAction() {
    callToAction.isEnabled = false
  }

  func updateForLoginAttempt() {
    setUpErrorMessageLabel()
    updateCallToActionForLoginAttempt()
    startActivityIndicator()
  }

  func updateAfterUnsuccessfulLoginAttempt(with errorMessage: String) {
    updateErrorMessageLabel(with: errorMessage)
    stopActivityIndicator()
    updateCallToActionAfterUnsuccessfulLoginAttempt()
  }

  func updateAfterSuccessfulLoginAttempt() {
    stopActivityIndicator()
    dismissKeyboard()
  }
}

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

    if textField == emailTextField {
      presenter.update(emailText: currentText)
    }

    if textField == passwordTextField {
      presenter.update(passwordText: currentText)
    }

    return true
  }
}

// MARK: - Private helper methods

private extension LoginViewController {

  func setUpEmailTextField() {
    emailTextField.placeholder = "Email"
    emailTextField.keyboardType = .emailAddress
  }

  func resetEmailTextField() {
    emailTextField.text = ""
  }

  func setUpPasswordTextField() {
    passwordTextField.placeholder = "Password"
    passwordTextField.isSecureTextEntry = true
  }

  func resetPasswordTextField() {
    passwordTextField.text = ""
  }

  func dismissKeyboard() {
    if emailTextField.isFirstResponder {
      emailTextField.resignFirstResponder()
    } else if passwordTextField.isFirstResponder {
      passwordTextField.resignFirstResponder()
    }
  }

  func setUpCallToAction() {
    callToAction.isEnabled = false

    callToAction.setTitle("Login", for: .normal)
    callToAction.setTitle("Login", for: .disabled)
  }

  func updateCallToActionForLoginAttempt() {
    callToAction.setTitle("Cancel", for: .normal)
    callToAction.setTitle("Cancel", for: .disabled)
  }

  func updateCallToActionAfterUnsuccessfulLoginAttempt() {
    callToAction.setTitle("Try again", for: .normal)
    callToAction.setTitle("Try again", for: .disabled)
  }

  func setUpActivityIndicator() {
    activityIndicator.hidesWhenStopped = true
    activityIndicator.stopAnimating()
  }

  func startActivityIndicator() {
    activityIndicator.startAnimating()
  }

  func stopActivityIndicator() {
    activityIndicator.stopAnimating()
  }

  func setUpErrorMessageLabel() {
    errorMessageLabel.text = ""
  }

  func updateErrorMessageLabel(with errorMessage: String) {
    errorMessageLabel.text = errorMessage
  }
}

// MARK: - Private design helper methods
// TODO: Move these to a "design system" package

private extension LoginViewController {

  func designEmailTextField() {
    emailTextField.layer.borderWidth = 1
    emailTextField.layer.cornerRadius = 5
  }

  func designEmailTextFieldForInitialState() {
    emailTextField.layer.borderColor = UIColor.black.cgColor
  }

  func designEmailTextFieldForValidState() {
    emailTextField.layer.borderColor = UIColor.blue.cgColor
  }

  func designEmailTextFieldForInvalidState() {
    emailTextField.layer.borderColor = UIColor.red.cgColor
  }

  func designPasswordTextField() {
    passwordTextField.layer.borderWidth = 1
    passwordTextField.layer.cornerRadius = 5
  }

  func designPasswordTextFieldForInitialState() {
    passwordTextField.layer.borderColor = UIColor.black.cgColor
  }

  func designPasswordTextFieldForValidState() {
    passwordTextField.layer.borderColor = UIColor.blue.cgColor
  }

  func designPasswordTextFieldForInvalidState() {
    passwordTextField.layer.borderColor = UIColor.red.cgColor
  }
}
