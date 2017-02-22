//
//  Errors.swift
//  batch13
//
//  Created by Francisco Ocampo Romero on 21/02/17.
//  Copyright © 2017 devf. All rights reserved.
//

import Foundation

enum AppError : Error {
  case Serialization
  case InvalidKey
  case InvalistCast
  
  var message : String {
    switch self {
    case .Serialization:
      return "Tuvimos un problema con esté JSON"
    default:
      return "Hubo un problema"
    }
  }
}
