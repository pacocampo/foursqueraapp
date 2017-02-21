//
//  MapViewController.swift
//  batch13
//
//  Created by Francisco Ocampo Romero on 16/02/17.
//  Copyright © 2017 devf. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
  
  var manager : CLLocationManager?
  var categoria : String!
  var categories: Set<String> = []
  var pines : [String : String] = [:]
  var service : MapService?
  var foursquare : FoursquareService!
  var coords: [String] = []
  var randomNumber : UInt32!

  @IBOutlet weak var mapView: MKMapView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      service = MapService(manager: self.manager!)
      service?.initMap(mapView)
      foursquare = FoursquareService(categoria: categoria, coords: self.manager!.location!.coordinate)
      foursquare.delegate = self
      foursquare.request()
//      mapView.delegate = self
      
     randomNumber = arc4random_uniform(UInt32(categories.count))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MapViewController : FoursquareDelegate {
  func showPointInMap(places: [Place?]) {
    
    for item in places {
      guard let place = item else {
        break
      }
      service?.addPointInMap(place : place , mapView: mapView)
    }
    print(categories)
    return
  } 
  
  func error(message: String, actions: [UIAlertAction]) {
    customAlert(view: self, message: message, action: actions)
    return
  }
}

//extension MapViewController : MKMapViewDelegate {
//  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//    
//    let view = MKAnnotationView(annotation: annotation, reuseIdentifier: "test")
//    view.annotation = annotation
//    view.image = UIImage(named: "pin1")
//    return view
//  }
//}
