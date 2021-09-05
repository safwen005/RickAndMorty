import XCTest
@testable import rick_morty

class AccessOperationsTests: XCTestCase {
  var accessUserAccount: AccessUserAccount?
  let validEmail = "saf@saf.saf"
  let validPassword = "123123"
  
  let wrongEmail = "sd@.saf"
  let wrongPassword = "12"
  
  override func setUp() {
    super.setUp()
    accessUserAccount = AccessUserAccount()
  }
  
  override func tearDown() {
    accessUserAccount = nil
  }
  
  func testRegister() {
    let creatValidAccount = creatAccount(email: validEmail, password: validPassword)
    XCTAssertTrue(creatValidAccount)
  }
  
  func testLogin() {
    let validLogin = loginAccount(email: validEmail, password: validPassword)
    XCTAssertTrue(validLogin == .success)
  }
  
  func creatAccount(email: String, password: String) -> Bool {
    guard let result = accessUserAccount?.createAccount(userEmail: email,
                                               userPassword: password) else { fatalError() }
    return result
  }
  
  func loginAccount(email: String, password: String) -> LoginResponse {
    guard let result = accessUserAccount?.loginAccount(userEmail: validEmail,
                                                       userPassword: validPassword) else { fatalError() }
    return result
  }
}
