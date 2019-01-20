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
    
    @IBAction func Signupclicked(_ sender: UIButton) {
    }
    func countryPhoneCodePicker(_ picker: MRCountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        // self.countryName.text = name
        //  self.countryCode.text = countryCode
        self.lblplus.text = phoneCode
        
        
    }
    
}
