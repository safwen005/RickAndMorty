import UIKit
import Kingfisher

class SearchTableViewCell: UITableViewCell, CharactersCellDelegate {
  @IBOutlet private weak var characterImageView: UIImageView!
  @IBOutlet private weak var characterStatusAndGenderLable: UILabel!
  @IBOutlet private weak var characterNameLabel: UILabel!
  @IBOutlet private weak var characterCardContainerView: UIView!
  @IBOutlet private weak var characterStatusImageView: UIImageView!
  private var controllerCharactersTableViewCell: ControlleCharacterTableViewCell?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    initializeCustomObjects()
    setNoneSelectionStyle()
    setCardContainerViewShape()
    setCharacterImageViewShape()
  }
  
  func initializeCustomObjects() {
    controllerCharactersTableViewCell = ControlleCharacterTableViewCell()
  }
  
  func setNoneSelectionStyle() {
    selectionStyle = UITableViewCell.SelectionStyle.none
  }
  
  func setCardContainerViewShape() {
    controllerCharactersTableViewCell?.setCardContainerViewShape(
      characterCardContainerView: characterCardContainerView)
  }
  
  func setCharacterImageViewShape() {
    controllerCharactersTableViewCell?.setCharacterImageViewShape(characterImageView: characterImageView)
  }
  
  func setCharacterInfoData(_ characterData: CharacterData) {
    guard
        let imageUrl = characterData.image,
        let status = characterData.status,
        let species = characterData.species,
        let name = characterData.name else {
             return
    }
    characterStatusAndGenderLable.text = "\(status.rawValue) - \(species.rawValue)"
    characterNameLabel.text = name
    characterStatusImageView.tintColor = (isAlive(status.rawValue) ? UIColorConstants.alertGreenColor : .gray)
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
  
  func isAlive(_ status: String) -> Bool {
    status == Status.alive.rawValue
  }
}
