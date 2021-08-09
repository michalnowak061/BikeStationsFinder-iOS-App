import Foundation

// MARK: - BikeStationsCodable
struct BikeStations: Codable {
  let features: [Station]
}

// MARK: - Station
struct Station: Codable {
  let geometry: Geometry
  let id, type: String
  let properties: Properties
}

// MARK: - Geometry
struct Geometry: Codable {
  let coordinates: [Double]
  let type: String
}

// MARK: - Properties
struct Properties: Codable {
  let freeRacks, bikes, label, bikeRacks, updated: String

  enum CodingKeys: String, CodingKey {
    case freeRacks = "free_racks"
    case bikes, label
    case bikeRacks = "bike_racks"
    case updated
  }
}
