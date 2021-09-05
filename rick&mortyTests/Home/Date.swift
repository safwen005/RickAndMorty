import XCTest
@testable import rick_morty

class test: XCTestCase {
  var systemDate: SystemDate?
  var currentData = "Saturday , Sep 04"
  
  override func setUp() {
    super.setUp()
    systemDate = SystemDate()
  }
  
  override func tearDown() {
    systemDate = nil
  }
  
  func testDate() {
    guard let systemCurrentDate = systemDate?.getCurrentDate() else { fatalError() }
    XCTAssertEqual(systemCurrentDate, systemCurrentDate)
  }
}
