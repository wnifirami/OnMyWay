//
//  AnnoncesecondViewController.swift
//  CARPOOLING
//
//  Created by Sam on 22/01/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit

class AnnoncesecondViewController: UIViewController {

    @IBOutlet weak var desctxt: UITextView!
    @IBOutlet weak var pricetxt: UITextField!
    @IBOutlet weak var nbrplaces: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func stepperClicked(_ sender: UIStepper) {
        nbrplaces.text = Int(sender.value).description
    }
    
    @IBAction func Cancelbtnclicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func nextbtnClicked(_ sender: UIButton) {
        
        if nbrplaces.text != "" && pricetxt.text != "" && desctxt.text != "" {
            let defaults = UserDefaults.standard
            
            defaults.set(nbrplaces.text!, forKey: "nbrplaces")
            defaults.set(pricetxt.text!, forKey: "prix")
            defaults.set(desctxt.text!, forKey: "desc")

            performSegue(withIdentifier: "stepthree", sender: self)
        }
        else {
            print("fer4a")
        }
       
    }
}
