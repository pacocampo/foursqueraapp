//
//  MapService.swift
//  batch13
//
//  Created by Francisco Ocampo Romero on 16/02/17.
//  Copyright © 2017 devf. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class MapService {
  
  var manager : CLLocationManager
  
  init(manager : CLLocationManager) {
    self.manager = manager
  }
  
  func initMap(_ mapView : MKMapView) {
    mapView.showsUserLocation = true
    let span = MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)
    let region = MKCoordinateRegion(center: manager.location!.coordinate, span: span)
    mapView.setRegion(region, animated: true)
  }
  
  func addPointInMap(place : Place, mapView : MKMapView) {
    let point = MKPointAnnotation()
    point.title = place.category
    point.coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
    let _ = mapView.annotations
    mapView.addAnnotation(point)
  }
}
