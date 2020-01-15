import UIKit

class SuccessViewController: UIViewController, SuccessViewContract {
  
  // MARK: - Properties

  @IBOutlet weak var messageLabel: UILabel!

  var presenter: SuccessPresenterContract!
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.viewWillAppear()
  }

  // MARK: - Public API

  func setUp() {
    messageLabel.text = "Hello!"
  }
}
