import Foundation

extension Data {
  func convertData<T: Decodable>() -> T? {
    guard let convertedData = try? JSONDecoder().decode(T.self, from: self) else {
      return nil
    }
    return convertedData
  }
}
