import Foundation

enum CharacterStatus {
  case all
  case alive
  case dead
  
  mutating func setNextStatus() {
    switch self {
    case .all:
      self = .alive
    case .alive:
      self = .dead
    case .dead:
      self = .all
    }
  }
}
