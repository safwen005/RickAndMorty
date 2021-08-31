import UIKit

class CharactersTableViewDelegate: NSObject, UITableViewDelegate {
  weak var delegate: CharactersDelegate?
  
  init(withDelegate delegate: CharactersDelegate) {
    self.delegate = delegate
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.delegate?.selectedCharacter(position: indexPath.row)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    tableView.getDefaultCharacterCardHeight()
  }
}
