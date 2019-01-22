
//
//  ProfileViewController.swift
//  CARPOOLING
//
//  Created by Sam on 22/01/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class ProfileViewController: UIViewController {
    @IBOutlet weak var namelbl: UILabel!
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var userimg: UIImageView!
    var id_user = UserDefaults.standard.string(forKey: "id")!

    override func viewDidLoad() {
        super.viewDidLoad()
email.text = UserDefaults.standard.string(forKey: "email")!
        phone.text = UserDefaults.standard.string(forKey: "num_tel")!
        adress.text = UserDefaults.standard.string(forKey: "adresse")!
        namelbl.text = UserDefaults.standard.string(forKey: "name")!
        print(UserDefaults.standard.string(forKey: "imageusr")!)
        if UserDefaults.standard.string(forKey: "imageusr")! != nil {
            let imgn = "http://marwen1994.alwaysdata.net/Carpooling/public/brahim/"+"\(UserDefaults.standard.string(forKey: "imageusr")!)"+".jpeg"
            
            
            userimg.af_setImage(withURL: URL(string: imgn)!)
        }

        // Do any additional setup after loading the view.
    }
    

  
    @IBAction func uploadpic(_ sender: UIButton) {
    }
    
}
