import UIKit

class CharactersTableViewDataSource: NSObject, UITableViewDataSource {
  private var charactersList = [CharacterData]()
  private var charactersListFilter = [CharacterData]()
  private var cellIdentifier = StringConstants.emptyField
  
  init(withIdentifier cellIdentifier: String) {
    self.cellIdentifier = cellIdentifier
  }
  
  func setNewData(_ newCharactersList: [CharacterData]) {
    self.charactersList = newCharactersList
    charactersListFilter = charactersList
  }
  
  func getCharacter(at position: Int) -> CharacterData {
    charactersListFilter[position]
  }
  
  func filterCharactersList(with: [CharacterFilterOption]) {
    charactersListFilter = charactersList
    with.forEach {
      filter in
      switch filter {
      case .status(let status):
        if status != .all {
          charactersListFilter = charactersListFilter.filter { character in
            guard let characterStatus = character.status?.rawValue else { return false }
            return (getCharacterStatus(characterStatus) == status)
          }
        }
      case .name(let searchName):
        charactersListFilter = charactersListFilter.filter { character in
          guard let characterName = character.name else { return false }
          return characterName.lowercased().contains(searchName.trim().lowercased())
        }
      case .species(let species):
        charactersListFilter = charactersListFilter.filter { character in
          guard let characterSpecies = character.species?.rawValue else { return false }
          return characterSpecies.lowercased().contains(species.trim().lowercased())
        }
      }
    }
  }
  
  func getCharacterStatus(_ characterStatus: String) -> CharacterStatus? {
    if characterStatus == Status.alive.rawValue {
      return CharacterStatus.alive
    }
    if characterStatus == Status.dead.rawValue {
      return CharacterStatus.dead
    }
    return nil
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    charactersListFilter.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,for: indexPath)
    guard let charactersCell = cell as? CharactersCellDelegate else { fatalError() }
    charactersCell.setCharacterInfoData(charactersListFilter[indexPath.row])
    return cell
  }
}
