import UIKit

class AuthenticationDefaultShape {
  private var loginButton: UIButton!
  private var registerButton: UIButton!
  
  init(loginButton: UIButton, registerButton: UIButton) {
    self.loginButton = loginButton
    self.registerButton = registerButton
  }
  
  func setAuthenticationButtonsShape() {
    setLoginButtonShape()
    setRegisterButtonShape()
  }
  
  func setLoginButtonShape() {
    loginButton.setCornerRadius(CGfloatConstants.defaultCornerRadius)
    loginButton.setBorderWidth(CGfloatConstants.defaultBorderWidth)
    loginButton.setBorderColor(.black)
  }
  func setRegisterButtonShape() {
    registerButton.setCornerRadius(CGfloatConstants.defaultCornerRadius)
  }
}
