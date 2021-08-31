import UIKit

class ControlleCustomAlert {
  private var emailStatus: UIStackView!
  private var emailIcon: UIImageView!
  private var emailTitle: UILabel!
  private var emailDescription: UILabel!
  private var passwordStatus: UIStackView!
  private var passwordIcon: UIImageView!
  private var passwordTitle: UILabel!
  private var passwordDescription: UILabel!
  
  init(emailStatus:UIStackView,
       emailIcon: UIImageView,
       emailTitle: UILabel,
       emailDescription: UILabel,
       passwordStatus: UIStackView,
       passwordIcon: UIImageView,
       passwordTitle: UILabel,
       passwordDescription: UILabel
  ) {
    self.emailStatus = emailStatus
    self.emailIcon = emailIcon
    self.emailTitle = emailTitle
    self.emailDescription = emailDescription
    self.passwordStatus = passwordStatus
    self.passwordIcon = passwordIcon
    self.passwordTitle = passwordTitle
    self.passwordDescription = passwordDescription
  }
  
  func setGoodEmail() {
    setEmail(backgroundColor: UIColorConstants.alertGreenColor,
             shadowColor: UIColorConstants.alertGreenColor,
             image: StringConstants.validField,
             title: StringConstants.successTitle,
             description: StringConstants.successEmailFormat)
  }
  
  func setBadFormatEmail() {
    setBadEmail()
    emailDescription.text = StringConstants.wrongEmailFormat
  }
  
  func setEmptyEmail() {
    setBadEmail()
    emailDescription.text = StringConstants.emptyEmailField
  }
  
  func setBadEmail() {
    setEmail(backgroundColor: UIColorConstants.alertRedColor,
             shadowColor: UIColorConstants.alertRedColor,
             image: StringConstants.notValidField,
             title: StringConstants.defaultAlertTitle)
  }
  
  func setGoodPassword() {
    setPassword(backgroundColor: UIColorConstants.alertGreenColor,
                shadowColor: UIColorConstants.alertGreenColor,
                image: StringConstants.validField,
                title: StringConstants.successTitle,
                description: StringConstants.successPasswordFormat)
  }
  
  func setEmptyPassword() {
    setPassword(backgroundColor: UIColorConstants.alertRedColor,
                shadowColor: UIColorConstants.alertRedColor,
                image: StringConstants.notValidField,
                title: StringConstants.defaultAlertTitle,
                description: StringConstants.emptyPasswordField)
  }
  
  func setWeakPassword() {
    setPassword(backgroundColor: UIColorConstants.alertMarronColor,
                shadowColor: UIColorConstants.alertMarronColor,
                image: StringConstants.warningField,
                title: StringConstants.warningTitle,
                description: StringConstants.beCarefullPassword)
  }
  
  func setPassword(
    backgroundColor: UIColor,
    shadowColor: UIColor,
    image: String,
    title: String,
    description: String) {
    passwordStatus.backgroundColor = backgroundColor
    passwordStatus.setCustomeShadow(color: shadowColor)
    passwordIcon.image = UIImage(named: image)
    passwordTitle.text = title
    passwordDescription.text = description
  }
  
  func setEmail(
    backgroundColor: UIColor,
    shadowColor: UIColor,
    image: String,
    title: String,
    description: String? = nil) {
    emailStatus.backgroundColor = backgroundColor
    emailStatus.setCustomeShadow(color: shadowColor)
    emailIcon.image = UIImage(named: image)
    emailTitle.text = title
    emailDescription.text = description
  }
  
}
