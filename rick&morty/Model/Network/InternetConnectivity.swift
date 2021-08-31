import Alamofire

struct InternetConnectivity {
  static let sharedInstance = NetworkReachabilityManager()
  
  static var isConnectedToInternet:Bool {
    return sharedInstance?.isReachable ?? true
  }
}
