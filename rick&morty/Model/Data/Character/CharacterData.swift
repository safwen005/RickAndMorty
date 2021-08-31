import Foundation

struct CharacterData: Codable {
  var id: Int?
  var name: String?
  var status: Status?
  var species: Species?
  var type: String?
  var gender: Gender?
  var origin, location: Location?
  var image: String?
  var episode: [String]?
  var url: String?
  var created: String?
}
