//
//  CustomControls.swift
//  batch13
//
//  Created by Francisco Ocampo Romero on 13/02/17.
//  Copyright © 2017 devf. All rights reserved.
//

import Foundation
import UIKit

class PasswordField : UITextField {
  override init(frame: CGRect) {
    super.init(frame: frame)
    customText()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    customText()
  }
  
  private func customText() {
    self.isSecureTextEntry = true
  }
}

func customAlert(view : UIViewController, message : String, action : [UIAlertAction]) {
  let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
  for item in action {
    alert.addAction(item)
  }
  view.present(alert, animated: true, completion: nil)
}
