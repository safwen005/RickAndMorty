import Foundation

class SystemDate {
  private var dateFormatter: DateFormatter = DateFormatter()
  private var currentDate: Date = Date()
  
  func getCurrentDate() -> String {
    dateFormatter.setTimeZone(.gregorian)
    dateFormatter.setFormat(DateFormattersConstants.defaultCurrentDayFormat)
    let currentDayName = getDate()
    dateFormatter.setFormat(DateFormattersConstants.defaultCurrentDayNumberFormat)
    let currentDay = getDate()
    dateFormatter.setFormat(DateFormattersConstants.defaultCurrentMonthFormat)
    let currentMonth = getDate()
    return "\(currentDayName) , \(currentMonth) \(currentDay)"
  }
  
  func getDate() -> String {
    dateFormatter.string(from: currentDate)
  }
}
