//
//  WelcomeViewController.swift
//  batch13
//
//  Created by Francisco Ocampo Romero on 13/02/17.
//  Copyright © 2017 devf. All rights reserved.
//

import UIKit
import CoreLocation

class WelcomeViewController: UIViewController {
  
  var manager : CLLocationManager = CLLocationManager()
  var categoria : String!
  let categorias = ["Comida", "Café", "Museos", "Co-Work", "Pet"]
  let imagenes = ["restaurante", "museo", "balcon", "caballo", "fachada" ]
  
  @IBAction func closeAction(_ sender: Any) {
    UserService.endSession()
    _ = self.navigationController?.popToRootViewController(animated: true)
  }
  
  @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
      collectionView.delegate = self
      collectionView.dataSource = self
      locationSettings()
       UserService.sendNotification()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func locationSettings()  {
    if CLLocationManager.authorizationStatus() == .notDetermined {
      self.manager.requestAlwaysAuthorization()
    }
    self.manager.startUpdatingLocation()
  }
    

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! MapViewController
        vc.manager = self.manager
        vc.categoria = self.categoria
    }
  

}

extension WelcomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return categorias.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! WelcomeCollectionViewCell
    cell.imagen.image = UIImage(named: imagenes[indexPath.item])
    cell.categoryLabel.text = categorias[indexPath.item]
    return cell
  }

  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.categoria = categorias[indexPath.item]
    //Hacemos la llamada al servicio segun la elección del usuario
      performSegue(withIdentifier: "menuToMap", sender: nil)
  }

  
}
