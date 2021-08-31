import Foundation

extension UserDefaults{
  struct UserCredentials: Encodable , Decodable {
    var password: String?
  }
  func createUserAccount(userEmail: String, userPassword: String) throws {
    let newPassword = UserCredentials(password: userPassword)
    try UserDefaults.standard.set(PropertyListEncoder().encode(newPassword), forKey: userEmail)
  }
  
  func loginUserAccount(userEmail: String, userPassword: String) throws -> LoginResponse {
    if UserDefaults.standard.object(forKey: userEmail) != nil {
      guard let userData = UserDefaults.standard.value(forKey: userEmail) as? Data else {
        return .errorOccurred
      }
      guard let userDataDecoder = try? PropertyListDecoder().decode(UserCredentials.self, from: userData)
      else {
        return .errorOccurred
      }
      if userDataDecoder.password == userPassword {
        return .success
      }
      return .incorrect
    }
    return .notExist
  }
}
