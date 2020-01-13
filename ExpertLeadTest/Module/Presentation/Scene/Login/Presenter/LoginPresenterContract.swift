import Foundation

protocol LoginPresenterContract: class {
  var useCase: LoginUseCaseContract { get }

  func viewDidLoad()
  func viewWillAppear()
}
