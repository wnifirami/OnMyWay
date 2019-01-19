//
//  SignupsecondViewController.swift
//  CARPOOLING
//
//  Created by Sam on 19/01/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit
import MRCountryPicker
import Alamofire
class SignupsecondViewController: UIViewController {
    
    @IBOutlet weak var cpicker: MRCountryPicker!
    @IBOutlet weak var phonenum: UITextField!
    @IBOutlet weak var location: UITextField!
    
    
    @IBOutlet weak var birthday: UITextField!
    @IBOutlet weak var lblplus: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func calendarbtnclicked(_ sender: UIButton) {
    }
    
    @IBAction func Signupclicked(_ sender: UIButton) {
    }
    
}
