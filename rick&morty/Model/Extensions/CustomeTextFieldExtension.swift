import UIKit

extension UITextField{
  func setDefaultPlaceHolder(_ placeHolder: String) {
    attributedPlaceholder = NSAttributedString(
      string: placeHolder,
      attributes: [NSAttributedString.Key.foregroundColor: UIColorConstants.defaultColor])
  }
  
  func setDefaultLeftPadding() {
    let paddingView = UIView(
      frame: CGRect(
        x: 0,
        y: 0,
        width: frame.width/25,
        height: frame.height))
    leftView = paddingView
    leftViewMode = .always
  }
  
  func checkReachedMaxLength(_ maxLength: Int) {
    guard let textCount = text?.count else { return }
    if (textCount > maxLength) {
      deleteBackward()
    }
  }
  
  func isValidEmail() -> Bool {
    guard let emailText = text else { return false }
    return emailText.trim().isVerifiedEmail()
  }
  
  func isValidPassword() -> Bool {
    guard let passwordText = text else { return false }
    return (passwordText.trim().count >= IntConstants.minimumPasswordLength)
  }
  
  func checkEmailMax() {
    checkReachedMaxLength(IntConstants.defaultEmailMaxLength)
  }
  
  func checkPasswordMax() {
    checkReachedMaxLength(IntConstants.defaultPasswordMaxLength)
  }
  
  func checkSearchMax() {
    checkReachedMaxLength(IntConstants.defaultSearchMaxLength)
  }
  
  func clear() {
    text = StringConstants.emptyField
  }
}
