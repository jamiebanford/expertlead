import UIKit

class LoginViewController: UIViewController, LoginViewContract {

  // MARK: - IB Outlets

  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var activityIndicatory: UIActivityIndicatorView!
  @IBOutlet weak var errorMessage: UILabel!

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
      print("Login pressed!")
  }
}
