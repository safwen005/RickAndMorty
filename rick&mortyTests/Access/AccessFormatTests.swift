import XCTest
@testable import rick_morty

class AccessFormatTests: XCTestCase {  
  func testEmailFormat() {
    let validEmail = "safwenchaieb@live.fr"
    let wrongEmail = "safwencsd@.fr"
    XCTAssertTrue(validEmail.count <= IntConstants.defaultEmailMaxLength)
    XCTAssertTrue(validEmail.isVerifiedEmail())
    XCTAssertFalse(wrongEmail.isVerifiedEmail())
  }
  
  func testPasswordFormat() {
    let validPassword = "123123"
    let wrongPassword = "12"
    let passwordRange = IntConstants.minimumPasswordLength...IntConstants.defaultPasswordMaxLength
    XCTAssertTrue(passwordRange.contains(validPassword.count))
    XCTAssertFalse(passwordRange.contains(wrongPassword.count))
  }
}
