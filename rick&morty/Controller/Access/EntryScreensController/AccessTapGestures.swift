import UIKit

class AccessTapGestures {
  private var containerView: UIView!
  private var backArrowIcon: UIImageView!
  private var emailTextField: UITextField!
  private var passwordTextField: UITextField!
  private var showHideIcon: UIImageView!
  private var backArrowAction: (() -> Void)?
  private var passwordReturnKeyAction : (() -> Void)?
  private var inputsStackFrame: CGRect?
  private var passwordIsHiden: Bool = true 
  
  init(containerView: UIView,
       backArrowIcon: UIImageView,
       emailTextField: UITextField,
       passwordTextField: UITextField,
       showHideIcon: UIImageView) {
    self.containerView = containerView
    self.backArrowIcon = backArrowIcon
    self.emailTextField = emailTextField
    self.passwordTextField = passwordTextField
    self.showHideIcon = showHideIcon
  }
  
  func prepareBackArrowTap(_ backArrowAction: (() -> Void)?) {
    self.backArrowAction = backArrowAction
    let tapGestureRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(performBackArrowAction))
    backArrowIcon.addGestureRecognizer(tapGestureRecognizer)
    backArrowIcon.isUserInteractionEnabled = true
  }
  
  func preparePasswordReturnKeyTap(passwordReturnKeyAction: (() -> Void)?) {
    self.passwordReturnKeyAction = passwordReturnKeyAction
    emailTextField.addTarget(
      self,
      action: #selector(performReturnKeyAction),
      for: UIControl.Event.primaryActionTriggered)
    
    passwordTextField.addTarget(
      self,
      action: #selector(performReturnKeyAction),
      for: UIControl.Event.primaryActionTriggered)
  }
  
  func prepareOutsideInputsTap(_ inputsStackFrame: CGRect) {
    self.inputsStackFrame = inputsStackFrame
    let dismissTap = UITapGestureRecognizer(
      target: self,
      action: #selector(prepareOutsideDismissAction(_:)))
    containerView.addGestureRecognizer(dismissTap)
  }
  
  func prepareShowHidePasswordTap() {
    let tapGestureRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(showOrHidePasswordAction))
    showHideIcon.addGestureRecognizer(tapGestureRecognizer)
    showHideIcon.isUserInteractionEnabled = true
  }
  
  func showPassword() {
    showHideIcon.image = UIImage(named: StringConstants.showPassword)
    passwordTextField.isSecureTextEntry = false
  }
  
  func hidePassword() {
    showHideIcon.image = UIImage(named: StringConstants.hidePassword)
    passwordTextField.isSecureTextEntry = true
  }
  
  @objc func showOrHidePasswordAction() {
    passwordIsHiden ? showPassword() : hidePassword()
    passwordIsHiden = !passwordIsHiden
  }
  
  @objc func performBackArrowAction() {
    backArrowAction?()
  }
  
  @objc func performReturnKeyAction(textField: UITextField) {
    if textField === emailTextField {
      passwordTextField.becomeFirstResponder()
      return
    }
    passwordReturnKeyAction?()
  }
  
  @objc func prepareOutsideDismissAction(_ sender: UITapGestureRecognizer? = nil) {
    guard let userTappedOutside = sender?.checkUserTapOutside(
            containerView,
            targetFrame: inputsStackFrame) else {
      return
    }
    
    if userTappedOutside {
      emailTextField.resignFirstResponder()
      passwordTextField.resignFirstResponder()
    }
  }
}
