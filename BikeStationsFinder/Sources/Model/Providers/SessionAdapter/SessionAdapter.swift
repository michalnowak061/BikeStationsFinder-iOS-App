import Foundation
import Alamofire

class SessionAdapter: SessionAdapterAdapting {
  let session: Session!

  init(session: Session = AF) {
    self.session = session
  }

  func response(_ convertible: URLConvertible, completionHandler: @escaping (AFError?, BikeStations?) -> Void) {
    let request = self.session.request(convertible)
    request.responseDecodable(of: BikeStations.self) { response in
      completionHandler(request.error, response.value)
    }
  }
}
