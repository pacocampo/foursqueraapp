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
  
  func returnDistance(from : CLLocationCoordinate2D, to : CLLocationCoordinate2D, mapView : MKMapView) -> String {
    let fromPoint = CLLocation(latitude: from.latitude, longitude: from.longitude)
    let toPoint = CLLocation(latitude: to.latitude, longitude: to.longitude)
    
    let result = toPoint.distance(from: fromPoint)
    
    return String("\(result) metros")
  }
  
  func traceRoute(from : CLLocationCoordinate2D, to: CLLocationCoordinate2D, mapView : MKMapView) {
    let fromPlaceMark = MKPlacemark(coordinate: from)
    let toPlaceMark = MKPlacemark(coordinate: to)
    
    let fromMapItem = MKMapItem(placemark: fromPlaceMark)
    let toMapItem = MKMapItem(placemark: toPlaceMark)
    
    let fromPin = MKPointAnnotation()
    fromPin.coordinate = from
    let toPin = MKPointAnnotation()
    toPin.coordinate = to
    
    mapView.showAnnotations([fromPin, toPin], animated: true)
    
    //solictar mejor ruta
    let directionRequest = MKDirectionsRequest()
    directionRequest.source = fromMapItem
    directionRequest.destination = toMapItem
    directionRequest.transportType = .walking
    
    let directions = MKDirections(request: directionRequest)
    
    directions.calculate { (response, error) in
      let route = response?.routes[0]
      mapView.add((route?.polyline)!, level: MKOverlayLevel.aboveRoads)
      
      //darle zoom al mapa
      let rect = route?.polyline.boundingMapRect
      mapView.setRegion(MKCoordinateRegionForMapRect(rect!), animated: true)
    }
    
  }
  
}











