import Foundation

enum NameOrSpecies {
  case name
  case species
  
  mutating func selecteNext() {
    if self == .name {
      self = .species
      return
    }
    self = .name
  }
}
