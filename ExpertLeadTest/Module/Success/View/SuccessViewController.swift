import UIKit

class SuccessViewController: UIViewController, SuccessViewContract {
    
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
}
