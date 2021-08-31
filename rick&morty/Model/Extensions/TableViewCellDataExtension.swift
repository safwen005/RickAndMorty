import UIKit

extension UIViewController {
  func getNib(_ cellIdentifier: String) -> UINib {
    UINib(nibName: cellIdentifier, bundle: nil)
  }
}

extension UITableView {
  func getDefaultCharacterCardHeight() -> CGFloat {
    frame.height/1.5
  }
}
