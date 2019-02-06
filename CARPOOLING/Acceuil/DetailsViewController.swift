//
//  DetailsViewController.swift
//  CARPOOLING
//
//  Created by Sam on 22/01/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit
import Cosmos
import AlamofireImage
import Alamofire
class DetailsViewController: UIViewController {
    @IBOutlet weak var carimg: UIImageView!
    let urladdnotif = "http://marwen1994.alwaysdata.net/Carpooling/public/addnotif.php"
    var urlgetrate = "http://marwen1994.alwaysdata.net/Carpooling/public/getRate.php"
    var nameimgcar = ""
    var rateval = ""
    @IBOutlet weak var destinationlbl: UILabel!
    var destination = ""
    @IBOutlet weak var minicarpic: UIImageView!
    @IBOutlet weak var cartype: UILabel!
    var cartypename = ""
    @IBOutlet weak var prixlbl: UILabel!
    var prix = ""
    @IBOutlet weak var datelbl: UILabel!
    var date = ""
    @IBOutlet weak var Desclbl: UILabel!
    var desc = ""
    @IBOutlet weak var rateview: CosmosView!
    @IBOutlet weak var userimg: UIImageView!
    var userid = ""
    var userimgname = ""
    var idannonce = ""
    
    @IBOutlet weak var sendrequestbtn: UIButton!
    
    @IBOutlet weak var feedbackbtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
carimg?.af_setImage(withURL: URL(string: nameimgcar)!)

        minicarpic?.af_setImage(withURL: URL(string: nameimgcar)!)
        userimg?.af_setImage(withURL: URL(string: userimgname)!)
        destinationlbl.text = destination
        cartype.text = cartypename
        Desclbl.text = desc
        prixlbl.text = prix
        datelbl.text = date
        destinationlbl.text = destination
        getRate()
        if userid == UserDefaults.standard.string(forKey: "id")! {
            
            sendrequestbtn.isHidden = true
            feedbackbtn.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        carimg?.af_setImage(withURL: URL(string: nameimgcar)!)
        
        minicarpic?.af_setImage(withURL: URL(string: nameimgcar)!)
        userimg?.af_setImage(withURL: URL(string: userimgname)!)
        destinationlbl.text = destination
        cartype.text = cartypename
        Desclbl.text = desc
        prixlbl.text = prix
        datelbl.text = date
        destinationlbl.text = destination
        getRate()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        carimg?.af_setImage(withURL: URL(string: nameimgcar)!)
        
        minicarpic?.af_setImage(withURL: URL(string: nameimgcar)!)
        userimg?.af_setImage(withURL: URL(string: userimgname)!)
        destinationlbl.text = destination
        cartype.text = cartypename
        Desclbl.text = desc
        prixlbl.text = prix
        datelbl.text = date
        destinationlbl.text = destination
        getRate()
    }
    
    
    @IBAction func callAction(_ sender: UIButton) {
        if let phoneURL = NSURL(string: ("tel://0021622222222" )) {
            let alert = UIAlertController(title: ("Call 0021622222222 ?"), message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Call", style: .default, handler: { (action) in
                UIApplication.shared.openURL(phoneURL as URL)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
   
    @IBAction func sendrequestClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func feedbackclicked(_ sender: UIButton) {
        performSegue(withIdentifier: "feeds", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "feeds" {
            //send parametre when we perform segue to details of the bar
            let feeds = segue.destination as? FeedsViewController
            feeds?.idannonce = idannonce
        }
        if segue.identifier == "chatwith" {
            //send parametre when we perform segue to details of the bar
            let feeds = segue.destination as? chatViewController
            feeds?.idget = userid
        }
    }
    func getRate(){
        
        let parameters: Parameters=[
            "id_annonce":idannonce,
            "id_user":UserDefaults.standard.string(forKey: "id")!,
            
            ]
        
        Alamofire.request(urlgetrate, method: .post, parameters: parameters).responseJSON
            {
                response  in
                
                
                
                //getting the json value from the server
                if let result = response.result.value  {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    //   print(jsonData)
                    
                    
                    let valuerate = jsonData.value(forKey: "items") as! [[String:Any]]
                 self.rateval = (valuerate[0]["value"]! as? String)!
                    //  print("valueodrateis" + "\((valuerate[0]["value"]! as? String)!)")
                    self.rateview.rating = Double((valuerate[0]["value"]! as? String)!)!
                }
                
        }
        
        
    }

    public func notifUser(flag:Bool, completionHandler: @escaping (Bool) -> Void ) {
        
        
        let parameters: Parameters=[
            "direction":destination,
            "id_user_reciever":userid,
            "id_user_sender":UserDefaults.standard.string(forKey: "id")!,
            
            ]
        Alamofire.request(urladdnotif, method: .post, parameters: parameters).responseJSON
            {
                response in
                
                //    print(response)
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    
                    //displaying the message in label
                    let val = jsonData.value(forKey: "response") as! String?
                    print("notifadedd")
                    
                }
                completionHandler(true)
                
        }
    }
    
    
    @IBAction func sendrequestclicked(_ sender: UIButton) {
        
        notifUser ( flag: true,completionHandler: { success in
            // print(self.BarsArray.count)
            print("notif is really added")
            
                
            })
                
    }
    
    @IBAction func messagebtnclicked(_ sender: UIButton) {
        performSegue(withIdentifier: "chatwith", sender: self)
    }
    
}
