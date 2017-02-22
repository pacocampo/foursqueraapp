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
  var places: [Place] = []
  var pines : [String : String] = [:]
  var service : MapService?
  var foursquare : FoursquareService!
  var coords: [String] = []
  var randomNumber : UInt32!

  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var tableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      service = MapService(manager: self.manager!)
      service?.initMap(mapView)
      foursquare = FoursquareService(categoria: categoria, coords: self.manager!.location!.coordinate)
      foursquare.delegate = self
      foursquare.request()
      mapView.delegate = self
      tableView.dataSource = self
      
      let otherCord = CLLocationCoordinate2D(latitude: 19.4158764, longitude: -99.1622857)
      
      let result = service?.returnDistance(from: (self.manager?.location?.coordinate)!, to: otherCord, mapView: mapView)
      print(result)
      
      service?.traceRoute(from: self.manager!.location!.coordinate, to: otherCord, mapView: self.mapView)
    
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
  func showPointInMap(places: [Place]) {
    self.places = places
    for place in places {
      service?.addPointInMap(place : place , mapView: mapView)
    }
    self.tableView.reloadData()
    return
  } 
  
  func error(message: String, actions: [UIAlertAction]) {
    customAlert(view: self, message: message, action: actions)
    return
  }
}

extension MapViewController : MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    let render = MKPolylineRenderer(overlay: overlay)
    render.strokeColor = UIColor.cyan
    render.lineWidth = 5.0
    
    return render
  }
  
}

extension MapViewController : UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.places.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell //id de storyboard
    let place = self.places[indexPath.row]
    cell.textLabel?.text = place.name
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    return
  }
}
