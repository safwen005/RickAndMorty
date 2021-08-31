import UIKit

class AccessViewsPrepare {
  private var emailTextField: UITextField!
  private var passwordTextField: UITextField!
  private var submitButton: UIButton!
  
  init(emailTextField: UITextField, passwordTextField: UITextField, submitButton: UIButton) {
    self.emailTextField = emailTextField
    self.passwordTextField = passwordTextField
    self.submitButton = submitButton
  }
  
  func prepareEmail() {
    prepareTextFieldShape(emailTextField)
    emailTextField.setDefaultPlaceHolder(StringConstants.defaultEmailPlaceholder)
  }
  
  func preparePassword() {
    prepareTextFieldShape(passwordTextField)
    passwordTextField.setDefaultPlaceHolder(StringConstants.defaultPasswordPlaceholder)
    passwordTextField.isSecureTextEntry = true
  }
  
  func prepareTextFieldShape(_ textField: UITextField) {
    textField.setBorderWidth(CGfloatConstants.defaultBorderWidth)
    textField.setDefaultLeftPadding()
  }
  
  func prepareSubmitButton() {
    submitButton.setCornerRadius(CGfloatConstants.defaultCornerRadius)
  }
}
