import Kingfisher

class DetailsViewController: UIViewController {
  @IBOutlet weak private var characterImage: UIImageView!
  @IBOutlet weak private var characterNameLabel: UILabel!
  @IBOutlet weak private var characterStatusLabel: UILabel!
  @IBOutlet weak private var characterSpeciesLabel: UILabel!
  @IBOutlet weak private var characterTypeLabel: UILabel!
  @IBOutlet weak private var characterGenderLabel: UILabel!
  @IBOutlet weak private var characterOriginLabel: UILabel!
  @IBOutlet weak private var characterLocationLabel: UILabel!
  @IBOutlet weak private var imageLoadingActivityIndicator: UIActivityIndicatorView!
  @IBOutlet weak private var existScreenIcon: UIImageView!
  private var characterData: CharacterData?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    hideNavigationBar()
    setViewsData()
    setExistScreenTapGesture()
  }
  
  func setViewsData() {
    guard let characterDetails = characterData else {
      popBackStack()
        return
    }
    setCharacterImage(url: characterDetails.image)
    characterNameLabel.text = characterDetails.name.getCleanValue(withDefault: Status.unknown.rawValue)
    characterStatusLabel.setTitleWith(key: CharacterFieldsConstants.status,
                                      value: characterDetails.status?.rawValue,
                                      defaultValue: Status.unknown.rawValue)
    characterSpeciesLabel.setTitleWith(key: CharacterFieldsConstants.species,
                                      value: characterDetails.species?.rawValue,
                                      defaultValue: Status.unknown.rawValue)
    characterTypeLabel.setTitleWith(key: CharacterFieldsConstants.type,
                                      value: characterDetails.type,
                                      defaultValue: Status.unknown.rawValue)
    characterGenderLabel.setTitleWith(key: CharacterFieldsConstants.gender,
                                      value: characterDetails.gender?.rawValue,
                                      defaultValue: Status.unknown.rawValue)
    characterOriginLabel.setTitleWith(key: CharacterFieldsConstants.origin,
                                      value: characterDetails.origin?.name,
                                      defaultValue: Status.unknown.rawValue)
    characterLocationLabel.setTitleWith(key: CharacterFieldsConstants.location,
                                      value: characterDetails.location?.name,
                                      defaultValue: Status.unknown.rawValue)
  }
  
  func setExistScreenTapGesture() {
    let exitTapGestureRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(exitScreen))
    existScreenIcon.addGestureRecognizer(exitTapGestureRecognizer)
    existScreenIcon.isUserInteractionEnabled = true
  }
  
  @objc func exitScreen() {
    popBackStack()
  }
  
  func setCharacterImage(url: String?) {
    characterImage.loadImage(
      url: url) {
      [weak self] in
      self?.imageLoadingActivityIndicator.startAnimating()
    } onSuccess: {
      [weak self] in
      self?.imageLoadingActivityIndicator.hide()
    } onFailure: {
      [weak self] in
      self?.imageLoadingActivityIndicator.hide()
      self?.setDefaultCharacterImage()
    }
  }
  
  func setDefaultCharacterImage() {
    characterImage.image = UIImage(named: TableViewConstants.defaultCharacterImage)
  }
  
  func setCharacter(_ selectedCharacter: CharacterData) {
    characterData = selectedCharacter
  }
}
