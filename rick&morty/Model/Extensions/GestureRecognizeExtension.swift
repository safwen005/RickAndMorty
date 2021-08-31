import UIKit

extension UITapGestureRecognizer {
  func checkUserTapOutside(_ container: UIView, targetFrame: CGRect?) -> Bool {
    guard let targetViewFrame = targetFrame else { return false }
    let touchPoint = location(in: container)
    return ((touchPoint.y < targetViewFrame.origin.y) || ((touchPoint.y) > targetViewFrame.origin.y + targetViewFrame.height))
  }
}
