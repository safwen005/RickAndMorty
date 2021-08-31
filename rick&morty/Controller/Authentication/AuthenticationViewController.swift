import UIKit

class AuthenticationViewController: UIViewController {
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var registerButton: UIButton!
  private var authenticationDefaultShape: AuthenticationDefaultShape?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initializeAuthenticationDefault()
    setButtonsShape()
  }
  
  func initializeAuthenticationDefault() {
    authenticationDefaultShape = AuthenticationDefaultShape(
      loginButton: loginButton,
      registerButton: registerButton)
  }
  
  func setButtonsShape() {
    authenticationDefaultShape?.setAuthenticationButtonsShape()
  }
}

