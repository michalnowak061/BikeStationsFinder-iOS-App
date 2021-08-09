import Foundation
import Alamofire

protocol SessionAdapterAdapting {
  func response(_ convertible: URLConvertible, completionHandler: @escaping (AFError?, BikeStations?) -> Void)
}
