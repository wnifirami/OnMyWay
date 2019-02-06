
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
import JGProgressHUD

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var uploadbtn: UIButton!
    
    @IBOutlet weak var namelbl: UILabel!
    let urlupload = "http://marwen1994.alwaysdata.net/Carpooling/public/setimg"
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var userimg: UIImageView!
    var id_user = UserDefaults.standard.string(forKey: "id")!

    override func viewDidLoad() {
        super.viewDidLoad()
        uploadbtn.isHidden = true
email.text = UserDefaults.standard.string(forKey: "email")!
        phone.text = UserDefaults.standard.string(forKey: "num_tel")!
        adress.text = UserDefaults.standard.string(forKey: "adresse")!
        namelbl.text = UserDefaults.standard.string(forKey: "name")!
        print(UserDefaults.standard.string(forKey: "imageusr")!)
        if UserDefaults.standard.string(forKey: "imageusr")! != nil {
            let imgn = "http://marwen1994.alwaysdata.net/Carpooling/public/brahim/"+"\(UserDefaults.standard.string(forKey: "imageusr")!)"+".jpeg"
            
            
            userimg.af_setImage(withURL: URL(string: imgn)!)
        }
imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    

  
    @IBAction func uploadpic(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage]
            as? UIImage else {
                return
        }
        
        userimg.image = image
        uploadbtn.isHidden = false

        self.dismiss(animated: true, completion: nil)
        // self.uploadimage ()
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func uploadimage () {
       
        //hud.show(in: self, animated: true)
        let myUrl =  "http://marwen1994.alwaysdata.net/Carpooling/public/setimg"
        
        
 
        var imageData = userimg.image!.pngData()
        
     
        let base64String = imageData?.base64EncodedString(options: .lineLength64Characters)
        
        let param = [
            "id" : id_user,
            "image":id_user,
            "image1":base64String!
            ] as [String : Any]
        Alamofire.request(myUrl,method: .post, parameters: param).responseJSON
            {
               
                response in
                 print(base64String)
                print("done")
                
                
        }
    }
    
    
    @IBAction func newuploadbtn(_ sender: UIButton) {
        let hud1 = JGProgressHUD(style: .light)
        hud1.textLabel.text = "Upload your pic in progress..."
        
        hud1.progress = 0.5
        //hud.show(in: self, animated: true)
        hud1.show(in: self.view)
        self.uploadimage ()
        hud1.dismiss()

    }
    
    
    
    @IBAction func LogoutbtnClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "logout", sender: self)
    }
    
    
    
}
