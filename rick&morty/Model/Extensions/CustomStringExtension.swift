import Foundation

extension Optional where Wrapped == String  {
  func getCleanValue(withDefault: String) -> String {
    guard let cleanValue = self else { return withDefault}
    if cleanValue.isEmpty {
      return withDefault
    }
    return cleanValue
  }
}
