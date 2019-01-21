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


class SignupsecondViewController: UIViewController,MRCountryPickerDelegate  {
    
    @IBOutlet weak var cpicker: MRCountryPicker!
    @IBOutlet weak var phonenum: UITextField!
    @IBOutlet weak var location: UITextField!
    var datepicker : UIDatePicker?
    var numtel : String!
    var telnum = ""
    @IBOutlet weak var birthday: UITextField!
    @IBOutlet weak var lblplus: UILabel!
    
var urlstore = "http://marwen1994.alwaysdata.net/Carpooling/public/storeUser"
    override func viewDidLoad() {
        super.viewDidLoad()
        cpicker.countryPickerDelegate = self
        cpicker.showPhoneNumbers = true
        cpicker.setCountryByPhoneCode("+216")
        self.datepicker = UIDatePicker()
        datepicker?.datePickerMode = .date
        datepicker?.addTarget(self, action: #selector(SignupsecondViewController.datechanged(datepicker:)), for: .valueChanged)
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignupsecondViewController.viewTapped(gestureRecognizer:)))
//        view.addGestureRecognizer(tapGesture)
        birthday.inputView = datepicker
        
        // Do any additional setup after loading the view.
    }
//    @objc func viewTapped(gestureRecognizer : UITapGestureRecognizer) {
//        view.endEditing(true)
//    }
    
    @objc func datechanged(datepicker : UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        birthday.text = formatter.string(from: datepicker.date )
        //view.endEditing(true)
    }

    @IBAction func calendarbtnclicked(_ sender: UIButton) {
        self.datepicker = UIDatePicker()
      datepicker?.datePickerMode = .date
    }
    
   
    func countryPhoneCodePicker(_ picker: MRCountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        // self.countryName.text = name
        //  self.countryCode.text = countryCode
        self.lblplus.text = phoneCode
        
        
    }
    public func StoreUser(name:String,email:String,password:String,num_tel:String,adresse:String,DateNaissance:String,flag:Bool, completionHandler: @escaping (Bool) -> Void ) {
        let parameters: Parameters=[
            "email":email,
            "name":name,
            "password":password,
            "num_tel":num_tel,
            "adresse":adresse,
            "DateNaissance":DateNaissance,
            ]
        Alamofire.request(urlstore, method: .post, parameters: parameters).responseJSON
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
                            print("added")
                            
                        }
                        else{
                           print("network error")
                            
                        }
                        
                    }
                    completionHandler(true)
                    
                }
        }
    }
    
    
    @IBAction func signup(_ sender: UIButton) {
        if self.phonenum.text != "" && self.birthday.text != "" && self.location.text != "" {
            let defaults = UserDefaults.standard
            
            StoreUser(name:defaults.string(forKey: "usernameadd")!,email: defaults.string(forKey: "emailadd")!, password: defaults.string(forKey: "passwordadd")!, num_tel: self.phonenum.text!, adresse: self.location.text!, DateNaissance: self.birthday.text!,flag: true,completionHandler: { success in
                  self.performSegue(withIdentifier: "blogintwo", sender: self)
            })
        }
        else {
            print("3abbi les champs")
        }
        
    }
    @IBAction func backtologin(_ sender: UIButton) {
        performSegue(withIdentifier: "blogintwo", sender: self)
    }
    
}
