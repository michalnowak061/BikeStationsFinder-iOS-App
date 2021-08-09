import Foundation
import CoreLocation

class BikeStationsParser: BikeStationsParserAdapting {
  func parse(bikeStations: BikeStations) -> [BikeStation] {
    var stations: [BikeStation] = []

    for bikeStation in bikeStations.features {
      let station = BikeStation(
        id: bikeStation.id,
        label: bikeStation.properties.label,
        freeBikes: Int(bikeStation.properties.bikes) ?? 0,
        freeRacks: Int(bikeStation.properties.freeRacks) ?? 0,
        coordinates: CLLocation(
          latitude: bikeStation.geometry.coordinates[1],
          longitude: bikeStation.geometry.coordinates[0]))

      stations.append(station)
    }

    return stations
  }
}
