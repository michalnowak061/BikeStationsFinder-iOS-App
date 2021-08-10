import MapKit

extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 100
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)

    setRegion(coordinateRegion, animated: true)
  }

  func deselectAllAnnotations() {
    for annotation in self.annotations {
      self.deselectAnnotation(annotation, animated: true)
    }
  }
}
