import Foundation

protocol BikeStationsManagerAdapting {
  var delegate: BikeStationsManagerDelegate? { get set }

  var count: Int { get }

  var selectedStationIndex: Int? { get set }

  func setStations(stations: [BikeStation])

  func fetchData(completion: @escaping (Bool) -> Void)

  func fetchAdress(atIndex index: Int, completion: @escaping (String?) -> Void)

  func sort(option: SortingOptions)

  func station(atIndex index: Int) -> BikeStation?
}
