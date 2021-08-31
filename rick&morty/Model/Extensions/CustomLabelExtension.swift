import UIKit

extension UILabel {
  func setTitleWith(key: String = StringConstants.emptyField,
                    value: String? = StringConstants.emptyField,
                    defaultValue: String = StringConstants.emptyField) {
    text = "\(key) : \(value.getCleanValue(withDefault: defaultValue))"
  }
}
