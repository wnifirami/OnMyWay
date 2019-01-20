//
//  SignupfirstViewController.swift
//  CARPOOLING
//
//  Created by Sam on 19/01/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit

class SignupfirstViewController: UIViewController {
    @IBOutlet weak var usernale: UITextField!
    
    @IBOutlet weak var confirmpassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    



    @IBAction func Nextbtnclicked(_ sender: UIButton) {
        if self.usernale.text != "" && self.email.text != "" && self.password.text != "" && self.confirmpassword.text != "" {
            if self.password.text != self.confirmpassword.text {
                let defaults = UserDefaults.standard
                
                defaults.set(self.usernale.text!, forKey: "usernameadd")
                defaults.set(self.email.text!, forKey: "emailadd")
                defaults.set(self.password.text!, forKey: "passwordadd")
                 print("lezm nafs l pass")
            }
            else{
                performSegue(withIdentifier: "signupnext", sender: self)

            }
        }
        else{
            print("3abbi les champs")
        }
    }
    
    @IBAction func backloginfirst(_ sender: UIButton) {
        performSegue(withIdentifier: "bloginone", sender: self)
    }
}
