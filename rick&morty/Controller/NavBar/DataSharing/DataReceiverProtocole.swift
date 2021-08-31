import Foundation

protocol DataReceiverProtocole {
  func onSuccess(_ data: Any)
  func onFailure(_ errorType: ResponseError)
}
