import UIKit

class CustomAlertTapGesture {
  private var containerView: UIView!
  private var inputsStackFrame: CGRect?
  private var dismissAction: (() -> Void)?
  
  init(_ containerView: UIView) {
    self.containerView = containerView
  }
  
  func prepareTapOutsideDismiss(inputsStackFrame: CGRect, dismissAction: @escaping (() -> Void)) {
    self.inputsStackFrame = inputsStackFrame
    self.dismissAction = dismissAction
    let dismissTap = UITapGestureRecognizer(target: self, action: #selector(outsideDismissAction(_:)))
    containerView.addGestureRecognizer(dismissTap)
  }
  
  @objc func outsideDismissAction(_ sender: UITapGestureRecognizer? = nil) {
    guard let userTapOutside = sender?.checkUserTapOutside(containerView, targetFrame: inputsStackFrame)
    else {
      return
    }
    if userTapOutside {
      dismissAction?()
    }
  }
}
