import UIKit

class LoginViewController: UIViewController {
  @IBOutlet private weak var backArrowIcon: UIImageView!
  @IBOutlet private weak var showHideIcon: UIImageView!
  @IBOutlet private weak var emailTextField: UITextField!
  @IBOutlet private weak var passwordTextField: UITextField!
  @IBOutlet private weak var submitButton: UIButton!
  @IBOutlet private weak var inputsStack: UIStackView!
  private var accessViewsPrepare: AccessViewsPrepare?
  private var accessUserAccount: AccessUserAccount?
  private var accessTapGestures: AccessTapGestures?
  private var accessAlerts: AccessDisplayAlerts?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    hideNavBackIcon()
    initializeAccessObjects()
    prepareViewsShape()
    prepareViewsTapGestures()
  }
  
  func initializeAccessObjects() {
    accessViewsPrepare = AccessViewsPrepare(
      emailTextField: emailTextField,
      passwordTextField: passwordTextField,
      submitButton: submitButton)
    
    accessUserAccount = AccessUserAccount()
    accessTapGestures = AccessTapGestures(
      containerView: view,
      backArrowIcon: backArrowIcon,
      emailTextField: emailTextField,
      passwordTextField: passwordTextField,
      showHideIcon: showHideIcon)
    
    accessAlerts = AccessDisplayAlerts(self)
  }
  
  func prepareViewsShape(){
    accessViewsPrepare?.prepareEmail()
    accessViewsPrepare?.preparePassword()
    accessViewsPrepare?.prepareSubmitButton()
  }
  
  func prepareViewsTapGestures() {
    setBackArrowAction()
    setPasswordReturnKeyAction()
    setTapOutsideDismissAction()
    setHideShowPasswordAction()
  }
  
  func setBackArrowAction() {
    accessTapGestures?.prepareBackArrowTap {
      [weak self] in
      self?.popBackStack()
    }
  }
  
  func setPasswordReturnKeyAction() {
    accessTapGestures?.preparePasswordReturnKeyTap {
      [weak self] in
      self?.performNextAction()
    }
  }
  
  func setTapOutsideDismissAction() {
    accessTapGestures?.prepareOutsideInputsTap(inputsStack.frame)
  }
  
  func setHideShowPasswordAction() {
    accessTapGestures?.prepareShowHidePasswordTap()
  }
  
  @IBAction func checkEmailLength(_ sender: Any) {
    emailTextField.checkEmailMax()
  }
  
  @IBAction func checkPasswordLength(_ sender: Any) {
    passwordTextField.checkPasswordMax()
  }
  
  @IBAction func performNextAction() {
    if (emailTextField.isValidEmail() && passwordTextField.isValidPassword()) {
      guard
        let loginResponse = accessUserAccount?.loginAccount(
          userEmail: emailTextField.text,
          userPassword: passwordTextField.text) else {
        accessAlerts?.showSimpleErrorAlert(.errorOccurred)
        return
      }
      if loginResponse == .success {
        navigate(StringConstants.fromLoginToHome)
        return
      }
      accessAlerts?.showSimpleErrorAlert(loginResponse)
      return
    }
    accessAlerts?.showCustomeAlert(userEmail: emailTextField.text, userPassword: passwordTextField.text)
  }
}


