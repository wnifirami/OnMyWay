//
//  ViewController.swift
//  CARPOOLING
//
//  Created by Sam on 18/01/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginbtn: UIButton!
    let urlLogin = "http://marwen1994.alwaysdata.net/Carpooling/public/loginpost.php"
    let urlcheck = "http://marwen1994.alwaysdata.net/Carpooling/public/checkUser"
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animate(withDuration: 2, animations: {
            self.logo.frame.origin.y = 100
            sleep(1)
//            self.loginbtn.alpha = 1.0
//            self.emai.alpha = 1.0
//            self.password.alpha = 1.0
           
        }, completion: {(finished:Bool) in
        })
    }
    
    public func checkUser(email:String,password:String,flag:Bool, completionHandler: @escaping (Bool) -> Void ) {
        let parameters: Parameters=[
            "email":email,
            "password":password,
            ]
        Alamofire.request(urlcheck, method: .post, parameters: parameters).responseJSON
            {
                response  in
                if let result = response.result.value  {
                    let jsonData = result as! NSDictionary
                    print(jsonData)
                    let val = jsonData.value(forKey: "result") as! String
                    if (val.count) != 0 {
                        let resp = val
                        print(resp)

                        if resp == "true" {
                       
                            self.login(email: self.email.text!, password: self.password.text!,flag: true,completionHandler: { success in
                                self.performSegue(withIdentifier: "toacceuil", sender: self)
                            })
                        }
                        else{
                           
                            
                        }
                    
                    }
                completionHandler(true)
                
        }
    }
    }
    
    
    
    public func login(email:String,password:String,flag:Bool, completionHandler: @escaping (Bool) -> Void ) {
       
        
        let parameters: Parameters=[
            "email":email,
            "password":password,
            
            ]
        
        Alamofire.request(urlLogin, method: .post, parameters: parameters).responseJSON
            {
                response  in
                
                
                
                //getting the json value from the server
                if let result = response.result.value  {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    print(jsonData)
                 
                    
                    
                    let val = jsonData.value(forKey: "items") as! [[String:Any]]
                    print(val[0]["name"]!)
                    let defaults = UserDefaults.standard
                    var image = ""
                    if val[0]["image"]! != nil {
                        image = val[0]["image"]! as! String
                        defaults.set(image, forKey: "imageusr")
print(val[0]["image"]!)
                    }
                  
                    defaults.set(val[0]["name"]!, forKey: "name")
                    defaults.set(val[0]["email"]!, forKey: "email")
                    defaults.set(val[0]["id"]!, forKey: "id")
                    defaults.set(val[0]["num_tel"]!, forKey: "num_tel")
                    defaults.set(val[0]["adresse"]!, forKey: "adresse")
                    defaults.set(val[0]["DateNaissance"]!, forKey: "DateNaissance")
                    defaults.set(self.password.text!, forKey: "normalpassword")
                    defaults.set(true, forKey: "loggedIn")
 
                }
                completionHandler(true)
                
        }
    }

    
    @IBAction func LoginPressed(_ sender: UIButton) {
        let mail =  self.email.text!
        let pass = self.password.text!
        if mail != "" && pass != "" {
            checkUser(email: mail, password: pass,flag: true,completionHandler: { success in
                
            })
        }
        
           }
    
    @IBAction func notmemberPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "join", sender: self)
    }
    
}

