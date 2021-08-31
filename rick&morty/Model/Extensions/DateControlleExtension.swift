import Foundation

extension DateFormatter {
  func setTimeZone(_ identifier: Calendar.Identifier) {
    timeZone = Calendar(identifier: identifier).timeZone
  }
  
  func setFormat(_ format: String) {
    dateFormat = format
  }
}
