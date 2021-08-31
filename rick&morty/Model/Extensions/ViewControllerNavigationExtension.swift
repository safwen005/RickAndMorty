import UIKit

extension UIViewController: UITextFieldDelegate {
  func hideNavBackIcon() {
    navigationItem.hidesBackButton = true
  }
  
  func hideTabBarNavBackIcon() {
    self.tabBarController?.navigationItem.hidesBackButton = true
  }
  
  func hideNavigationBar() {
    navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  func showNavigationBar() {
    navigationController?.setNavigationBarHidden(false, animated: false)
  }
  
  func popBackStack() {
    guard let navigationController = navigationController else { return }
    if (navigationController.viewControllers.count > 1) {
      navigationController.popViewController(animated: true)
    }
  }
  
  func navigate(_ identifier: String, data:Any?=nil) {
    performSegue(withIdentifier: identifier, sender: data)
  }
  
  func dismiss() {
    dismiss(animated: true, completion: nil)
  }
  
  func getViewController(_ fromStoryboard: String, withName: String) -> UIViewController {
    let storyboard = UIStoryboard(name: fromStoryboard, bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: withName)
    return viewController
  }
  
  func removeThisViewControllerFromStack() {
    guard let navigationController = navigationController else { return }
    var navigationArray = navigationController.viewControllers
    navigationArray.removeAll(where: {
      [weak self] in
      $0 === self
    })
    self.navigationController?.viewControllers = navigationArray
  }
  
  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}

