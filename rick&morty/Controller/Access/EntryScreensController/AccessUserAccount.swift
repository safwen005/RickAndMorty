import UIKit

class AccessUserAccount {
  private var userDefaults: UserDefaults?
  
  init() {
    userDefaults = UserDefaults()
  }
 
  func createAccount(userEmail: String?, userPassword: String?) -> Bool {
    guard
        let email = userEmail,
        let password = userPassword else {
              return false
    }
    
    guard
        let _ = try? userDefaults?.createUserAccount(
          userEmail: email,
          userPassword: password) else {
              return false
    }
    
    return true
  }
  
  func loginAccount(userEmail: String?, userPassword: String?) -> LoginResponse {
    guard
        let email = userEmail,
        let password = userPassword else {
      return .errorOccurred
    }
    guard
        let loginResponse = try? userDefaults?.loginUserAccount(
          userEmail: email,
          userPassword: password) else {
      return .errorOccurred
    }
    return loginResponse
  }
}
