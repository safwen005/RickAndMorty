import UIKit

extension UIView {
  func setCornerRadius(_ radius: CGFloat) {
    layer.cornerRadius = radius
  }
  
  func setSquareImageShape(_ radius: CGFloat) {
    layer.cornerRadius = radius/1.8
  }
  
  func setTopCornerRadius(_ radius: CGFloat) {
    setCornerRadius(radius)
    layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
  }
  
  func clipToBounds() {
    clipsToBounds = true
  }
  
  func hide() {
    isHidden = true
  }
  
  func show() {
    isHidden = false
  }
  
  func isVisible() -> Bool {
    !isHidden
  }
  
  func setBorderColor(_ color: UIColor) {
    layer.borderColor = color.cgColor
  }
  
  func setBorderWidth(_ width: CGFloat=0) {
    layer.borderWidth = width
  }
  
  func setBackgroundColor(_ color: UIColor) {
    backgroundColor = color
  }
  
  func setCustomeShadow(
    radius: CGFloat = CGfloatConstants.defaultShadowRadius,
    opacity: Float = FloatConstants.defaultShadowOpacity,
    shadowXY: CGFloat = CGfloatConstants.defaultShadowXY,
    color: UIColor) {
    layer.masksToBounds = false
    layer.shadowRadius = radius
    layer.shadowOpacity = opacity
    layer.shadowOffset = CGSize(width: shadowXY, height: shadowXY)
    layer.shadowColor = color.withAlphaComponent(alpha).cgColor
  }
  
  
}
