import Foundation

protocol DataSenderProtocole {
  func sendSuccess(to: NavBarItems, data: Any)
  func sendFailure(to: NavBarItems, error: ResponseError)
}
