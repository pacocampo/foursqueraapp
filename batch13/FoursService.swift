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

protocol FoursquareDelegate {
  var coords : [String] { get set }
  func showPointInMap(coords : [CLLocationCoordinate2D])
  func error(message : String, actions : [UIAlertAction])
}

class FoursquareService {
  
  var delegate : FoursquareDelegate?
  
  let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
  
  ///funcion para hacer request, recibe un argumento categoria
  func request(categoria : String, coords : CLLocationCoordinate2D ) {
    /*Creamos los parametros con el tipo 'Parameters' de alamofire
    estos parametros provienen de la documentación de foursquare */
    let parameters : Parameters = ["v":"20170101",
                                   "client_id" : "4OROBZEIVETX2B15RTAKH1YBGQQBO1MTURTI5HBBBLT4JT4P",
                                   "client_secret":"AMTLJVIBN11RWPTNZPWWTOUKVEVOWFFWIO2DQMHYU5PHHC2K",
                                   "ll": coords.toString(),
                                   "query": categoria,
                                    "radius":"800"]
    ///Hace la llamada al URL indicado y agrega los parametros
    Alamofire.request("https://api.foursquare.com/v2/venues/search", parameters : parameters)
      //valida el status code de la respuesta del api
      .validate(statusCode: 200..<300)
      //toma el request y nos envía la respuesta
      .responseJSON { response in
        
        var coordList : [CLLocationCoordinate2D] = []
        
        //Evalua si la respuesta no es exitosa
        if response.result.isFailure {
            self.delegate?.error(message: "Aquí la cagamos", actions: [self.okAction])
        }
        //Convierte la respuesta en json con el framework SwiftyJSON
        let json = JSON(response.result.value)
        
        let data = json["response"]["venues"]
        for (_, value) in data {
          let coordinate = CLLocationCoordinate2D(latitude: value["location"]["lat"].double!, longitude: value["location"]["lng"].double!)
          coordList.append(coordinate)
        }
        self.delegate?.showPointInMap(coords: coordList)
    }

  }
}













