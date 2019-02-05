//
//  ViewController.swift
//  CARPOOLING
//
//  Created by Sam on 18/01/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit
import JSSAlertView
import Alamofire
import JGProgressHUD
import UserNotifications
class ViewController: UIViewController {
   
    
    @IBOutlet weak var email: UITextField!
//   var  helloWorldTimer: Timer!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginbtn: UIButton!

    //URL
    let urlLogin = "http://marwen1994.alwaysdata.net/Carpooling/public/loginpost.php"
    let urlcheck = "http://marwen1994.alwaysdata.net/Carpooling/public/checkUser"
    override func viewDidLoad() {
        super.viewDidLoad()
         let contnent = UNMutableNotificationContent()
        contnent.title = "Carpooling"
        contnent.body = "hello there"
        contnent.sound = UNNotificationSound.default
        //event after 5 seconds to lunch notification
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "test", content: contnent, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
//         helloWorldTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ViewController.sayHello), userInfo: nil, repeats: true)
//
     
        UIView.animate(withDuration: 2, animations: {
            self.logo.frame.origin.y = 100
            sleep(1)
//            self.loginbtn.alpha = 1.0
//            self.emai.alpha = 1.0
//            self.password.alpha = 1.0
           
        }, completion: {(finished:Bool) in
        })
    }
//    @objc func sayHello()
//    {
//        print("hello World")
//    }
    
    public func checkUser(email:String,password:String,flag:Bool, completionHandler: @escaping (Bool) -> Void ) {
        let hud1 = JGProgressHUD(style: .light)
        hud1.textLabel.text = "Authentification..."
        
        hud1.progress = 0.5
        //hud.show(in: self, animated: true)
        hud1.show(in: self.view)
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
                        hud1.dismiss()

                        if resp == "true" {
                       
                            self.login(email: self.email.text!, password: self.password.text!,flag: true,completionHandler: { success in
                                self.performSegue(withIdentifier: "toacceuil", sender: self)
//                                self.helloWorldTimer?.invalidate()
                            })
                        }
                        else{
                            JSSAlertView().show(
                                self, // the parent view controller of the alert
                                title: "Please check your email or password", // the alert's title
                                delay: 2 // time in secs
                            )
                           
                        }
                    
                    }
                    else {
                        JSSAlertView().show(
                            self, // the parent view controller of the alert
                            title: " Please check your network ", // the alert's title
                            delay: 2 // time in secs
                        )
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

