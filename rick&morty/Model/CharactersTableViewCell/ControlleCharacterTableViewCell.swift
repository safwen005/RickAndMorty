import UIKit

class ControlleCharacterTableViewCell {
  func setCardContainerViewShape(characterCardContainerView: UIView) {
    characterCardContainerView.setCornerRadius(CGfloatConstants.characterCornerRadius)
    
    characterCardContainerView.setCustomeShadow(
      radius: CGfloatConstants.characterCardShadowRadius,
      opacity: FloatConstants.characterShadowOpacity,
      shadowXY: CGfloatConstants.characterCardShadowXY,
      color: UIColorConstants.littleDarkColor)
  }
  
  func setCharacterImageViewShape(characterImageView: UIImageView) {
    characterImageView.setTopCornerRadius(CGfloatConstants.characterCornerRadius)
  }
}
