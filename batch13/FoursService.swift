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

class FoursquareService {
  ///funcion para hacer request, recibe un argumento categoria
  func request(categoria : String) {
    /*Creamos los parametros con el tipo 'Parameters' de alamofire
    estos parametros provienen de la documentación de foursquare */
    let parameters : Parameters = ["v":"20170101",
                                   "client_id" : "4OROBZEIVETX2B15RTAKH1YBGQQBO1MTURTI5HBBBLT4JT4P",
                                   "client_secret":"AMTLJVIBN11RWPTNZPWWTOUKVEVOWFFWIO2DQMHYU5PHHC2K",
                                   "ll": "19.4142776,-99.1622213",
                                   "query": categoria,
                                    "radius":"800"]
    ///Hace la llamada al URL indicado y agrega los parametros
    Alamofire.request("https://api.foursquare.com/v2/venues/search", parameters : parameters)
      //valida el status code de la respuesta del api
      .validate(statusCode: 200..<300)
      //toma el request y nos envía la respuesta
      .responseJSON { response in
        //Evalua si la respuesta no es exitosa
        if response.result.isFailure {
          print("aqui la cagamos")
        }
        //Convierte la respuesta en json con el framework SwiftyJSON
        let json = JSON(response.result.value)
        //Accedemos al nivel de 'venues' de la respuesta del api
        let data = json["response"]["venues"]
        // imprimimos cada nombre del venue si es que existe.
        for (_, value) in data {
          print(value["name"])
        }
    }
  }
}


