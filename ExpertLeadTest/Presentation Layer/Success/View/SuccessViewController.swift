import UIKit

class SuccessViewController: UIViewController, SuccessViewContract {

  // MARK: - IBOutlets

  @IBOutlet var successMessageLabel: UILabel!

  // MARK: - Properties

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
    successMessageLabel.text = "Hello!"
  }
}
