import UIKit

extension UIButton {
  func setTitleAndColor(title: String, color: UIColor = .white) {
    setTitle(title, for: .normal)
    setTitleColor(color, for: .normal)
  }
}
