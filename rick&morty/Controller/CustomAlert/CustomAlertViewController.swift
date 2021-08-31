import UIKit

class CustomAlertViewController: UIViewController {
  enum result {
    case good
    case badFormat
    case weak
    case empty
  }
  
  @IBOutlet weak var alertCard: UIView!
  @IBOutlet weak var emailStatus: UIStackView!
  @IBOutlet weak var emailIcon: UIImageView!
  @IBOutlet weak var emailTitle: UILabel!
  @IBOutlet weak var emailDescription: UILabel!
  @IBOutlet weak var passwordStatus: UIStackView!
  @IBOutlet weak var passwordIcon: UIImageView!
  @IBOutlet weak var passwordTitle: UILabel!
  @IBOutlet weak var passwordDescription: UILabel!
  @IBOutlet weak var dismissButton: UIButton!
  private var prepareCustomViews: CustomAlertViewsPrepare?
  private var prepareCustomAlert: ControlleCustomAlert?
  private var prepareCustomTapGestures: CustomAlertTapGesture?
  private var emailResult: result?
  private var passwordResult: result?
  var firstTime: Bool = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initializeCustomObjects()
    prepareViews()
    prepareEmailStatus()
    preparePasswordStatus()
  }
  
  func initializeCustomObjects() {
    firstTime = false
    prepareCustomAlert = ControlleCustomAlert(
      emailStatus: emailStatus,
      emailIcon: emailIcon,
      emailTitle: emailTitle,
      emailDescription: emailDescription,
      passwordStatus: passwordStatus,
      passwordIcon: passwordIcon,
      passwordTitle: passwordTitle,
      passwordDescription: passwordDescription)
    
    prepareCustomViews = CustomAlertViewsPrepare(
      emailStatus: emailStatus,
      passwordStatus: passwordStatus,
      dismissButton: dismissButton)
    
    prepareCustomTapGestures = CustomAlertTapGesture(view)
  }
  
  func prepareViews() {
    prepareViewsShape()
    prepareTapOutsideDismiss()
  }
  
  func isFirstTime() -> Bool {
    firstTime
  }
  
  func prepareViewsShape() {
    prepareCustomViews?.prepareViewsShape()
  }
  
  @IBAction func dismissAlert() {
    dismiss()
  }
  
  func prepareTapOutsideDismiss() {
    prepareCustomTapGestures?.prepareTapOutsideDismiss(
      inputsStackFrame: alertCard.frame,
      dismissAction: {
        [weak self] in
        self?.dismiss()
      })
  }
  
  func setEmailStatus(_ email: result) {
    emailResult = email
  }
  
  func setPasswordStatus(_ password: result) {
    passwordResult = password
  }
  
  func prepareEmailStatus() {
    switch emailResult {
    case .good:
      prepareCustomAlert?.setGoodEmail()
    case .badFormat:
      prepareCustomAlert?.setBadFormatEmail()
    case .empty:
      prepareCustomAlert?.setEmptyEmail()
    default:
      break
    }
  }
  
  func preparePasswordStatus() {
    switch passwordResult {
    case .good:
      prepareCustomAlert?.setGoodPassword()
    case .weak:
      prepareCustomAlert?.setWeakPassword()
    case .empty:
      prepareCustomAlert?.setEmptyPassword()
    default:
      break
    }
  }
}
