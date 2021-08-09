import Foundation
@testable import BikeStationsFinder

let bikeStationsStub = BikeStations(
  features: [
    Station(
      geometry: Geometry(coordinates: [0, 0], type: "type"),
      id: "0000",
      type: "type",
      properties: Properties(
        freeRacks: "0",
        bikes: "0",
        label: "label",
        bikeRacks: "0",
        updated: "0"))
  ])
