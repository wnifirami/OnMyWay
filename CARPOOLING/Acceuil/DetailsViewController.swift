//
//  DetailsViewController.swift
//  CARPOOLING
//
//  Created by Sam on 22/01/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit
import Cosmos
import AlamofireImage
import Alamofire
class DetailsViewController: UIViewController {
    @IBOutlet weak var carimg: UIImageView!
    var nameimgcar = ""
    @IBOutlet weak var destinationlbl: UILabel!
    var destination = ""
    @IBOutlet weak var minicarpic: UIImageView!
    @IBOutlet weak var cartype: UILabel!
    var cartypename = ""
    @IBOutlet weak var prixlbl: UILabel!
    var prix = ""
    @IBOutlet weak var datelbl: UILabel!
    var date = ""
    @IBOutlet weak var Desclbl: UILabel!
    var desc = ""
    @IBOutlet weak var rateview: CosmosView!
    @IBOutlet weak var userimg: UIImageView!
    var userimgname = ""
    var idannonce = ""
    override func viewDidLoad() {
        super.viewDidLoad()
carimg?.af_setImage(withURL: URL(string: nameimgcar)!)

        minicarpic?.af_setImage(withURL: URL(string: nameimgcar)!)
        userimg?.af_setImage(withURL: URL(string: userimgname)!)
        destinationlbl.text = destination
        cartype.text = cartypename
        Desclbl.text = desc
        prixlbl.text = prix
        datelbl.text = date
        destinationlbl.text = destination
        // Do any additional setup after loading the view.
    }
    
    @IBAction func callAction(_ sender: UIButton) {
        if let phoneURL = NSURL(string: ("tel://0021622222222" )) {
            let alert = UIAlertController(title: ("Call 0021622222222 ?"), message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Call", style: .default, handler: { (action) in
                UIApplication.shared.openURL(phoneURL as URL)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
   
    @IBAction func sendrequestClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func feedbackclicked(_ sender: UIButton) {
        performSegue(withIdentifier: "feeds", sender: self)
    }
    
    
    

}
