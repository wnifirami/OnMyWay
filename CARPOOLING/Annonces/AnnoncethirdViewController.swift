//
//  AnnoncethirdViewController.swift
//  CARPOOLING
//
//  Created by Sam on 22/01/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class AnnoncethirdViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    var urladdannonce = "http://marwen1994.alwaysdata.net/Carpooling/public/addPost"
    @IBOutlet weak var cartypetxt: UITextField!
    @IBOutlet weak var datetxt: UITextField!
    var datepicker : UIDatePicker?

    let imagePicker = UIImagePickerController()

    @IBOutlet weak var carimg: UIImageView!
    
    @IBOutlet weak var uploadbtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadbtn.isHidden = true
        imagePicker.delegate = self
datepicker = UIDatePicker()
        datepicker?.datePickerMode = .date
        datepicker?.addTarget(self, action: #selector(SignupsecondViewController.datechanged(datepicker:)), for: .valueChanged)
        datetxt.inputView = datepicker

        
    }
    @objc func datechanged(datepicker : UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        self.datetxt.text = formatter.string(from: datepicker.date )
        //view.endEditing(true)
    }
    
    @IBAction func cancelbtnclicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
    @IBAction func DonebtnisClicked(_ sender: UIButton) {
        StoreAnnonce( flag: true,completionHandler: { success in
            // print(self.BarsArray.count)
            print("compdone")
self.performSegue(withIdentifier: "backtohome", sender: self)
        })
    }
    
    
    @IBAction func choosepicClicked(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage]
            as? UIImage else {
                return
        }
        
        carimg.image = image
        self.uploadbtn.isHidden = false
        self.dismiss(animated: true, completion: nil)
        // self.uploadimage ()
    }
    
    @IBAction func uploadClicked(_ sender: UIButton) {
        self.uploadimage()
    }
    
    func uploadimage () {
        
        //hud.show(in: self, animated: true)
        let myUrl =  "http://marwen1994.alwaysdata.net/Carpooling/public/setimg"
        
        
        
        var imageData = carimg.image!.pngData()
        
        
        let base64String = imageData?.base64EncodedString(options: .lineLength64Characters)
        
        let param = [
            "id" : UserDefaults.standard.string(forKey: "imagename")!,
            "image":UserDefaults.standard.string(forKey: "imagename")!,
            "image1":base64String!
            ] as [String : Any]
        Alamofire.request(myUrl,method: .post, parameters: param).responseJSON
            {
                
                response in
                print(base64String)
                let defaults = UserDefaults.standard
                
                defaults.set(base64String!, forKey: "imagecode")
                print("done upload pic")
                
                
        }
    }
    
    
    public func StoreAnnonce(flag:Bool, completionHandler: @escaping (Bool) -> Void ) {
        let parameters: Parameters=[
            "idUser":UserDefaults.standard.string(forKey: "id")!,
            "adresseDepart":UserDefaults.standard.string(forKey: "depart")!,
            "adresseArrive":UserDefaults.standard.string(forKey: "arrive")!,
            "nbrPlace":UserDefaults.standard.string(forKey: "nbrplaces")!,
            "imageVoiture":UserDefaults.standard.string(forKey: "arrive")!,
            "Description":UserDefaults.standard.string(forKey: "desc")!,
            "prix":UserDefaults.standard.string(forKey: "prix")!,
            "type":self.cartypetxt.text!,
            "datedeplassement":self.datetxt.text!,
            "imageuser":UserDefaults.standard.string(forKey: "id")!,
            "numtel":UserDefaults.standard.string(forKey: "num_tel")!,
            "Imagecode":UserDefaults.standard.string(forKey: "imagecode")!,
            ]
        Alamofire.request(urladdannonce, method: .post, parameters: parameters).responseJSON
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
    
    
    
}
