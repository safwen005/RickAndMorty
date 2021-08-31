import UIKit

class HomeViewController: UIViewController, CharactersDelegate, DataSenderProtocole {
  @IBOutlet private weak var currentDateLabel: UILabel!
  @IBOutlet private weak var rickAndMortyIcon: UIImageView!
  @IBOutlet private weak var charactersTableView: UITableView!
  @IBOutlet private weak var dataLoadingIndicator: UIActivityIndicatorView!
  @IBOutlet private weak var errorStackView: UIStackView!
  @IBOutlet private weak var errorDescriptionLabel: UILabel!
  private var charactersTableViewDataSource: CharactersTableViewDataSource?
  private var charactersTableViewDelegate: CharactersTableViewDelegate?
  private var dataSharingHelper: DataSharingHelper?
  private var networkCalls: NetworkCalls?
  private var systemDate: SystemDate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    hideTabBarNavBackIcon()
    initializeCustomObjects()
    prepareViewsShape()
    prepareCurrentDate()
    prepareCharactersTableView()
    getCharactersFromApi()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    hideNavigationBar()
  }
  
  func initializeCustomObjects() {
    systemDate = SystemDate()
    networkCalls = NetworkCalls()
    dataSharingHelper = DataSharingHelper()
  }
  
  func prepareViewsShape() {
    prepareRickAndMortyIconShape(rickAndMortyIcon: rickAndMortyIcon)
  }
  
  func prepareCurrentDate() {
    currentDateLabel.text = systemDate?.getCurrentDate()
  }
  
  func prepareRickAndMortyIconShape(rickAndMortyIcon:UIImageView){
    rickAndMortyIcon.setSquareImageShape(rickAndMortyIcon.frame.size.width)
    rickAndMortyIcon.clipToBounds()
  }
  
  func prepareCharactersTableView(){
    charactersTableView.register(
      getNib(TableViewConstants.HomeTableViewCellIdentifier),
      forCellReuseIdentifier: TableViewConstants.HomeTableViewCellIdentifier)
    charactersTableViewDataSource = CharactersTableViewDataSource(
      withIdentifier: TableViewConstants.HomeTableViewCellIdentifier)
    charactersTableViewDelegate = CharactersTableViewDelegate(withDelegate: self)
    charactersTableView.delegate = charactersTableViewDelegate
    charactersTableView.dataSource = charactersTableViewDataSource
  }
  
  func getCharactersFromApi() {
    dataLoadingIndicator.startAnimating()
    networkCalls?.performGetRequest(
      url: NetworkStringDataConstants.charactersApi,
      method: .get,
      onSuccess: {
        [weak self ] responseData in
        self?.dataLoadingIndicator.hide()
        guard
            let rickAndMortyResponse: RickAndMortyResponse = responseData.convertData(),
            let charactersList = rickAndMortyResponse.results else {
             self?.showErrorStack()
             self?.setErrorDescription(NetworkStringDataConstants.errorOccuredDescription)
               return
        }
        self?.setNewData(charactersList: charactersList)
        self?.sendSuccess(to: .search, data: charactersList)
      },
      onFailure: {
        [weak self] responseError in
        self?.dataLoadingIndicator.hide()
        self?.showErrorStack()
        switch responseError {
        case .noInternetConnection:
          self?.setErrorDescription(NetworkStringDataConstants.noInternetErrorDescription)
        case .other:
          self?.setErrorDescription(NetworkStringDataConstants.errorOccuredDescription)
        }
        self?.sendFailure(to: .search, error: responseError)
      })
  }
  
  @IBAction func tryAgain() {
    errorStackView.hide()
    dataLoadingIndicator.show()
    getCharactersFromApi()
  }
  
  func setNewData(charactersList: [CharacterData]) {
    self.charactersTableView.show()
    self.reloadCharactersTableViewData(charactersList)
  }
  
  func reloadCharactersTableViewData(_ newCharactersList: [CharacterData]) {
    charactersTableViewDataSource?.setNewData(newCharactersList)
    charactersTableView.reloadData()
  }
  
  func setErrorDescription(_ description: String) {
    errorDescriptionLabel.text = description
  }
  
  func showErrorStack() {
    charactersTableView.hide()
    errorStackView.show()
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
    navigate(StringConstants.fromHomeToDetails, data: selectedCharacter)
  }
  
  func sendSuccess(to: NavBarItems, data:Any) {
    guard let dataReceiver = dataSharingHelper?.getReceiver(
            withIndex: to,
            fromTabBar: tabBarController) else { return }
    dataReceiver.onSuccess(data)
  }
  
  func sendFailure(to: NavBarItems, error:ResponseError) {
    guard let dataReceiver = dataSharingHelper?.getReceiver(
            withIndex: to,
            fromTabBar: tabBarController) else { return }
    dataReceiver.onFailure(error)
  }
}
