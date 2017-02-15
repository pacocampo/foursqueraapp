//
//  WelcomeViewController.swift
//  batch13
//
//  Created by Francisco Ocampo Romero on 13/02/17.
//  Copyright © 2017 devf. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

  let categorias = ["Comida", "Café", "Nocturna", "Diversión", "Compras"]
  let imagenes = ["restaurante", "museo", "balcon", "caballo", "fachada" ]
  
  @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
      collectionView.delegate = self
      collectionView.dataSource = self

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
  
}
