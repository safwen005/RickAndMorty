import Alamofire

class NetworkCalls {
  func performGetRequest(
    url: String,
    method: HTTPMethod,
    parameters: Parameters?=nil,
    onSuccess:@escaping (Data) -> Void,
    onFailure: @escaping (ResponseError) -> Void) {
    if !InternetConnectivity.isConnectedToInternet {
      onFailure(.noInternetConnection)
      return
    }
    AF.request(url,
               method: method,
               parameters: parameters
    ){
      urlRequest in
      urlRequest.timeoutInterval = NetworkIntDataConstants.defaultTimeOut
    }.response{
      response in
      guard
        let responseData = response.data else {
        onFailure(.other)
        return
      }
      onSuccess(responseData)
    }
  }
}
