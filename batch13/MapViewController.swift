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
  var service : MapService?
  let foursquare = FoursquareService()
  var coords: [String] = []

  @IBOutlet weak var mapView: MKMapView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      service = MapService(manager: self.manager!)
      service?.initMap(mapView)
      foursquare.delegate = self
      foursquare.request(categoria: categoria, coords: self.manager!.location!.coordinate)
      
      
      let coords = CLLocationCoordinate2D(latitude: 19.4161193, longitude: -99.1618566)
      
      service?.addPointInMap(coords: coords, mapView: mapView)
     
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
  func showPointInMap(coords: [CLLocationCoordinate2D]) {
    print("chingon")
    return
  }
  
  func error(message: String, actions: [UIAlertAction]) {
    customAlert(view: self, message: message, action: actions)
    return
  }
}
