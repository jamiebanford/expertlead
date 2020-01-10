import Foundation

protocol LoginPresenterContract: class {
  var interactor: LoginInteractorContract { get }

  func viewDidLoad()
  func viewWillAppear()
}
