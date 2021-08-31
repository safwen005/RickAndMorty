import UIKit

class CustomAlertViewsPrepare {
  private var emailStatus: UIStackView!
  private var passwordStatus: UIStackView!
  private var dismissButton: UIButton!
  
  init(emailStatus: UIStackView, passwordStatus: UIStackView, dismissButton: UIButton) {
    self.emailStatus = emailStatus
    self.passwordStatus = passwordStatus
    self.dismissButton = dismissButton
  }
  
  func prepareViewsShape() {
    emailStatus.setCornerRadius(CGfloatConstants.defaultCornerRadius)
    passwordStatus.setCornerRadius(CGfloatConstants.defaultCornerRadius)
    dismissButton.setBorderWidth(CGfloatConstants.defaultBorderWidth)
  }
}
