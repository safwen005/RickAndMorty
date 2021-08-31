import UIKit

class SearchViewController: UIViewController, CharactersDelegate, DataReceiverProtocole {
  @IBOutlet weak private var searchTextField: UITextField!
  @IBOutlet weak private var nameButton: UIButton!
  @IBOutlet weak private var statusButton: UIButton!
  @IBOutlet weak private var speciesButton: UIButton!
  @IBOutlet weak private var charactersTableView: UITableView!
  @IBOutlet weak private var dataContainer: UIView!
  @IBOutlet weak private var errorStackView: UIStackView!
  @IBOutlet weak private var errorDescriptionLabel: UILabel!
  private var charactersTableViewDataSource: CharactersTableViewDataSource?
  private var charactersTableViewDelegate: CharactersTableViewDelegate?
  private var prepareSearchViewsShape: ControlleSearchView?
  private var characterStatus: CharacterStatus = .all
  private var nameOrSpecies: NameOrSpecies = .name
  private var viewControllerFirstTime = true
  private var responseError: ResponseError?
  private var charactersList = [CharacterData]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initializeObjects()
    prepareCharactersTableView()
    prepareViewsDefaultShape()
    showResponseResult()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    showNavigationBar()
  }
  
  func initializeObjects() {
    prepareSearchViewsShape = ControlleSearchView()
    searchTextField.delegate = self
  }
  
  func prepareCharactersTableView(){
    charactersTableView.register(
      getNib(TableViewConstants.SearchTableViewCellIdentifier),
      forCellReuseIdentifier: TableViewConstants.SearchTableViewCellIdentifier)
    charactersTableViewDataSource = CharactersTableViewDataSource(
      withIdentifier: TableViewConstants.SearchTableViewCellIdentifier)
    charactersTableViewDelegate = CharactersTableViewDelegate(withDelegate: self)
    charactersTableView.delegate = charactersTableViewDelegate
    charactersTableView.dataSource = charactersTableViewDataSource
  }
  
  func prepareViewsDefaultShape() {
    prepareSearchViewsShape?.prepareSearchField(searchTextField)
    prepareSearchViewsShape?.prepareViewsDefaultShape(
      nameButton: nameButton,
      statusButton: statusButton,
      speciesButton: speciesButton)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if !viewControllerFirstTime {
      showResponseResult()
      return
    }
    viewControllerFirstTime = false
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    resetViewsStat()
  }
  
  func resetViewsStat() {
    nameButton.setBackgroundColor(UIColorConstants.softBlue)
    searchTextField.clear()
    statusButton.setBackgroundColor(UIColorConstants.softGray)
    statusButton.setTitleAndColor(title: Status.all.rawValue, color: .black)
    characterStatus = .all
    nameOrSpecies = .name
  }
  
  @IBAction func searchTextChanged(_ sender: UITextField) {
    sender.checkSearchMax()
    filterCharacters()
  }
  
  @IBAction func setNameSelected() {
    if nameOrSpecies == .species {
      nameOrSpecies.selecteNext()
      nameButton.setBackgroundColor(UIColorConstants.softBlue)
      speciesButton.setBackgroundColor(UIColorConstants.softGray)
      filterCharacters()
    }
  }
  
  @IBAction func setStatusSelected()  {
    switch characterStatus {
    case .all:
      statusButton.setTitleAndColor(title: Status.alive.rawValue)
      statusButton.setBackgroundColor(UIColorConstants.softBlue)
    case .alive:
      statusButton.setTitleAndColor(title: Status.dead.rawValue)
    case .dead:
      statusButton.setTitleAndColor(title: Status.all.rawValue, color: .black)
      statusButton.setBackgroundColor(UIColorConstants.softGray)
    }
    characterStatus.setNextStatus()
    filterCharacters()
  }
  
  @IBAction func setSpeciesSelected() {
    if nameOrSpecies == .name {
      speciesButton.setBackgroundColor(UIColorConstants.softBlue)
      nameButton.setBackgroundColor(UIColorConstants.softGray)
      nameOrSpecies.selecteNext()
      filterCharacters()
    }
  }
  
  func filterCharacters() {
    guard let filters = prepareSearchViewsShape?.filterCharacters(
      searchText: searchTextField.text,
      nameOrSpecies: nameOrSpecies,
            status: characterStatus) else { return }
    charactersTableViewDataSource?.filterCharactersList(with: filters)
    charactersTableView.reloadData()
  }
  
  func showResponseResult() {
    if !charactersList.isEmpty {
      errorStackView.hide()
      charactersTableViewDataSource?.setNewData(charactersList)
      charactersTableView.reloadData()
      return
    }
    if responseError != nil {
      prepareSearchViewsShape?.showError(errorStackView: errorStackView, dataContainer: dataContainer)
      prepareSearchViewsShape?.setErrorDescription(
        errorType: responseError,
        errorDescriptionLabel: errorDescriptionLabel)
    }
  }
  
  func onSuccess(_ data: Any) {
    guard let NewCharactersList = data as? [CharacterData] else {
      responseError = .other
      return
    }
    charactersList = NewCharactersList
  }
  
  func onFailure(_ errorType: ResponseError) {
    responseError = errorType
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard
        let detailsScreen = segue.destination as? DetailsViewController,
        let selectedCharacter = sender as? CharacterData else {
          return
    }
    detailsScreen.setCharacter(selectedCharacter)
  }
  
  func selectedCharacter(position: Int) {
    let selectedCharacter = charactersTableViewDataSource?.getCharacter(at: position)
    navigate(StringConstants.fromSearchToDetails, data: selectedCharacter)
  }
}
