import Foundation

extension String {
  var isEmail: Bool {
    let emailRegex = StringConstants.emailRegexPattern
    let emailTest = NSPredicate(
      format:StringConstants.selfMatchRegexPattern,
      emailRegex)
    return emailTest.evaluate(with: self)
  }
  
  func isVerifiedEmail() -> Bool {
    return (!isEmpty && isEmail)
  }
  
  func trim() -> String {
    trimmingCharacters(in: .whitespacesAndNewlines)
  }
}
