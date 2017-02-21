//
//  Place.swift
//  batch13
//
//  Created by Francisco Ocampo Romero on 20/02/17.
//  Copyright © 2017 devf. All rights reserved.
//

import Foundation
import SwiftyJSON

class Place {
  var name      : String
  var latitude  : Double
  var longitude : Double
//  var photo     : String?
  var address   : String?
  var category  : String
  
  init?(json : JSON) {
    guard let name = json["name"].string,
    let latitude = json["location"]["lat"].double,
    let longitude = json["location"]["lng"].double,
    let category = json["categories"][0]["name"].string else {
        return nil
    }
    self.name = name
    self.latitude = latitude
    self.longitude = longitude
//    self.photo = json["categories"][0]["icon"]["prefix"].string! + ".png"
    self.address = json["location"]["address"].string
    self.category = category
  }
}
