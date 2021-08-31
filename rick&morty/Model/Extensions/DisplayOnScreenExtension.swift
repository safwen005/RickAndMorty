import UIKit

extension UIViewController {
  func present(_ viewController: UIViewController?) {
    guard let newViewController = viewController else { return }
      self.present(newViewController, animated: true, completion: nil)
  }
  
  func creatSimpleAlert(_ title: String="", message: String="", agree: String="") -> UIAlertController {
    let simpleAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    simpleAlert.addAction(UIAlertAction(title: agree, style: UIAlertAction.Style.default, handler: nil))
    return simpleAlert
  }
}
