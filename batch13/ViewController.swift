//
//  ViewController.swift
//  batch13
//
//  Created by Francisco Ocampo Romero on 02/02/17.
//  Copyright © 2017 devf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var loginButton : UIButton!
  
  @IBAction func goToMain(_ sender : UIButton) {
    var valid = true
    for case let text as UITextField in self.view.subviews {
      if text.text!.isEmpty {
        valid = false
      }
    }
    if valid {
      // creamos una instancia del view controller a navegar
      let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
      // lo presentamos
      self.present(vc, animated: true, completion: nil)
    } else {
      
      //Creamos acción para el ok
      let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
        print("hice algo con la acción")
      })
      
      //Creamos acción para el cancel
      let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
      let acciones : [UIAlertAction] = [okAction, cancelAction]
      
      //Lama a funcion custom alert
      customAlert(view: self, message: "La cagaste con las credenciales", action: acciones)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    addGestureToView()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  }

