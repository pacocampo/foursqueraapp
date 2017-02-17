//
//  extensions.swift
//  batch13
//
//  Created by Francisco Ocampo Romero on 13/02/17.
//  Copyright © 2017 devf. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation.CLLocation

/// Extensión para esconder teclado en ViewController
extension UIViewController {
  func addGestureToView() {
    let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  
  func dismissKeyboard() {
    view.endEditing(true)
  }

}

extension CLLocationCoordinate2D {
  func toString() -> String {
    return "\(self.latitude), \(self.longitude)"
  }
}
