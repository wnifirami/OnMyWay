//
//  AcceuilViewController.swift
//  CARPOOLING
//
//  Created by Sam on 20/01/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class AcceuilViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   var urlgetAll = "http://marwen1994.alwaysdata.net/Carpooling/public/getallPostnew"
    
    @IBOutlet weak var pubTable: UITableView!
    var AnnoncesArray = [AnyObject]()

    @IBOutlet weak var searchbar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        GetAll( flag: true,completionHandler: { success in
            // print(self.BarsArray.count)
            print("compdone")
            self.pubTable.reloadData()
        })

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AnnoncesArray.count    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pubTable.dequeueReusableCell(withIdentifier: "cellAcc")
        let direction = cell?.viewWithTag(1) as? UILabel
         let date = cell?.viewWithTag(2) as? UILabel
        let carimg = cell?.viewWithTag(3)as? UIImageView
         let userimg = cell?.viewWithTag(4)as? UIImageView
         let nbrPlaces = cell?.viewWithTag(5) as? UILabel
         let prix = cell?.viewWithTag(6) as? UILabel
        var annonce = AnnoncesArray[indexPath.row] as! Dictionary<String , Any>
        direction?.text = "\(annonce["adresseDepart"] as! String)  --> \(annonce["adresseArrive"] as! String)"
        date?.text = annonce["datedeplassement"] as! String
        nbrPlaces?.text = annonce["nbrPlace"] as! String
        prix?.text = annonce["prix"] as! String
           let imgn = "http://marwen1994.alwaysdata.net/Carpooling/public/brahim/"+"\(annonce["imageVoiture"] as! String)"+".jpeg"
        
         let userimgn = "http://marwen1994.alwaysdata.net/Carpooling/public/brahim/"+"\(annonce["imageuser"] as! String)"+".jpeg"
        print (userimgn)
        carimg?.af_setImage(withURL: URL(string: imgn)!)
        userimg?.af_setImage(withURL: URL(string: userimgn)!)

        return cell!
    }

   
    func GetAll( flag:Bool, completionHandler: @escaping (Bool) -> Void ) {
        
        
        Alamofire.request(urlgetAll).responseJSON
            {
                response  in
                
                
                //getting the json value from the server
                
                
                let result = response.result
                if let dict = result.value as? Dictionary<String,AnyObject>{
                    
                    self.AnnoncesArray = dict["annonces"] as! [AnyObject]
                    
                    //  self.BarsArray = innerdict as! [AnyObject]
                    // let val = jsonData.value(forKey: "") as! [[String:Any]]
                    
                    
                    
                    
                    
                }
                completionHandler(true)
        }
    }

}
