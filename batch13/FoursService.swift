//
//  FoursService.swift
//  batch13
//
//  Created by Francisco Ocampo Romero on 14/02/17.
//  Copyright © 2017 devf. All rights reserved.
//

import Foundation
// mis pods
import Alamofire
import SwiftyJSON
import CoreLocation.CLLocation

enum Endpoints : String {
  case getPlaces = "https://api.foursquare.com/v2/venues/search"
}

protocol FoursquareDelegate {
  var coords : [String] { get set }
  var categories : Set<String> {get set}
  func showPointInMap(places : [Place?])
  func error(message : String, actions : [UIAlertAction])
}

class FoursquareService {
  
  let version = "20170101"
  let clientId = "4OROBZEIVETX2B15RTAKH1YBGQQBO1MTURTI5HBBBLT4JT4P"
  let clientSecret = "AMTLJVIBN11RWPTNZPWWTOUKVEVOWFFWIO2DQMHYU5PHHC2K"
  var radius : String = "800"
  var coords : CLLocationCoordinate2D
  var categoria = ""
  var parameters : Parameters
  
  init?(categoria : String, coords : CLLocationCoordinate2D) {
    self.categoria = categoria
    self.coords = coords
    self.parameters = ["v": version, "client_id" : clientId ,"client_secret": clientSecret, "ll": coords.toString(), "query": categoria, "radius":radius]
    
  }
  
  
  var delegate : FoursquareDelegate?
  
  let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
  
  ///funcion para hacer request, recibe un argumento categoria
  func request() {
    ///Hace la llamada al URL indicado y agrega los parametros
    Alamofire.request(Endpoints.getPlaces.rawValue, parameters : self.parameters)
      //valida el status code de la respuesta del api
      .validate(statusCode: 200..<300)
      //toma el request y nos envía la respuesta
      .responseJSON { response in
        
        //Evalua si la respuesta no es exitosa
        if response.result.isFailure {
            self.delegate?.error(message: "Aquí la cagamos", actions: [self.okAction])
        }
        //Convierte la respuesta en json con el framework SwiftyJSON
        let json = JSON(response.result.value)
        
        let data = json["response"]["venues"]
        var places : [Place?] = []
        var categories : Set<String> = []
        for (_, value) in data {
          let place = Place(json:value)
          if place != nil {
           categories.insert(place!.category)
          }
          places.append(place)
        }
        self.delegate?.showPointInMap(places: places)
        self.delegate?.categories = categories
    }

  }
}













