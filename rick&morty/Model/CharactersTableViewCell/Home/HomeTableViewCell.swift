import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell, CharactersCellDelegate {
  @IBOutlet private weak var characterImageView: UIImageView!
  @IBOutlet private weak var characterStatusAndGenderLable: UILabel!
  @IBOutlet private weak var characterNameLabel: UILabel!
  @IBOutlet private weak var characterCardContainerView: UIView!
  private var controllerHomeTableViewCell: ControlleCharacterTableViewCell?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    initializeCustomObjects()
    setNoneSelectionStyle()
    setCardContainerViewShape()
    setCharacterImageViewShape()
  }
  
  func initializeCustomObjects() {
    controllerHomeTableViewCell = ControlleCharacterTableViewCell()
  }
  
  func setNoneSelectionStyle() {
    selectionStyle = UITableViewCell.SelectionStyle.none
  }
  
  func setCardContainerViewShape() {
    controllerHomeTableViewCell?.setCardContainerViewShape(
      characterCardContainerView: characterCardContainerView)
  }
  
  func setCharacterImageViewShape() {
    controllerHomeTableViewCell?.setCharacterImageViewShape(characterImageView: characterImageView)
  }
  
  func setCharacterInfoData(_ characterData: CharacterData) {
    guard
        let imageUrl = characterData.image,
        let status = characterData.status,
        let gender = characterData.gender,
        let name = characterData.name else {
             return
    }
    characterStatusAndGenderLable.text = "\(status.rawValue) - \(gender.rawValue)"
    characterNameLabel.text = name
    guard let imageLink = URL(string: imageUrl) else {
      setDefaultCharacterImage()
      return
    }
    KF.url(imageLink).onFailure{
      [weak self] _ in
      self?.setDefaultCharacterImage()
    }.set(to: characterImageView)
  }
  
  func setDefaultCharacterImage() {
    characterImageView.image = UIImage(named: TableViewConstants.defaultCharacterImage)
  }
}
