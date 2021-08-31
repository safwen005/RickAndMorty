import UIKit

class AccessDisplayAlerts {
  private var viewController: UIViewController?
  private var simpleErrorAlert: UIAlertController?
  private var customAlert: CustomAlertViewController?
  private var simpleErrorAlertStat: LoginResponse?
  
  init(_ viewController: UIViewController) {
    self.viewController = viewController
    simpleErrorAlert = getSimpleErrorAlert()
  }
  
  func getSimpleErrorAlert() -> UIAlertController? {
    return viewController?.creatSimpleAlert(
      StringConstants.defaultAlertTitle,
      agree: StringConstants.defaultAlertAgree)
  }
  
  func prepareSimpleErrorAlert(_ stat: LoginResponse) {
    if (simpleErrorAlertStat == nil || simpleErrorAlertStat != stat)  {
      simpleErrorAlertStat = stat
      switch simpleErrorAlertStat {
      case .incorrect:
        setSimpleAlertMessage(StringConstants.incorrectUserPassword)
      case .notExist:
        setSimpleAlertMessage(StringConstants.accountNotExist)
      case .errorOccurred:
        setSimpleAlertMessage(StringConstants.defaultAlertMessage)
      default:
        break
      }
    }
  }
  
  func setSimpleAlertMessage(_ description: String) {
    simpleErrorAlert?.message = description
  }
  
  func showSimpleErrorAlert(_ stat: LoginResponse) {
    prepareSimpleErrorAlert(stat)
    viewController?.present(simpleErrorAlert)
  }
  
  func prepareCustomAlert() -> CustomAlertViewController? {
    return viewController?.getViewController(
      StringConstants.customeStoryBoardName,
      withName: StringConstants.customeAlertIdentifier) as? CustomAlertViewController
  }
  
  func showCustomeAlert(userEmail: String?, userPassword: String?) {
    if customAlert == nil {
      customAlert = prepareCustomAlert()
    }
    
    guard
      let email = userEmail,
      let password = userPassword else {
      return
    }
    setEmailStatus(email)
    setPasswordStatus(password)
    
    guard let isFirstTime = customAlert?.isFirstTime() else { return }
    if !isFirstTime {
      customAlert?.prepareEmailStatus()
      customAlert?.preparePasswordStatus()
    }
    viewController?.present(customAlert)
  }
  
  func setEmailStatus(_ email: String) {
    let trimmedEmail = email.trim()
    switch true {
    case trimmedEmail.isEmpty :
      customAlert?.setEmailStatus(.empty)
    case !trimmedEmail.isVerifiedEmail() :
      customAlert?.setEmailStatus(.badFormat)
    default:
      customAlert?.setEmailStatus(.good)
    }
  }
  
  func setPasswordStatus(_ password: String) {
    let trimmedPassword = password.trim()
    switch true {
    case trimmedPassword.isEmpty:
      customAlert?.setPasswordStatus(.empty)
    case trimmedPassword.count < IntConstants.minimumPasswordLength :
      customAlert?.setPasswordStatus(.weak)
    default:
      customAlert?.setPasswordStatus(.good)
    }
  }
}
