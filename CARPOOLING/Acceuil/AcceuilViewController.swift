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
import Floaty
import JGProgressHUD

class AcceuilViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   var urlgetAll = "http://marwen1994.alwaysdata.net/Carpooling/public/getallPostnew"
    var fetching = false
    @IBOutlet weak var pubTable: UITableView!
    var AnnoncesArray = [AnyObject]()
    var AnnoncesArrayFiltred = [AnyObject]()

    @IBOutlet weak var searchbar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        let floaty = Floaty()
        floaty.addItem("Add post", icon: UIImage(named: "addannoncenew")!, handler: { item in
            self.performSegue(withIdentifier: "addannonce", sender: self)
            //            let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .Alert)
            //            alert.addAction(UIAlertAction(title: "Me too", style: .Default, handler: nil))
            //            self.presentViewController(alert, animated: true, completion: nil)
            floaty.close()
        })
        floaty.addItem("Profile", icon: UIImage(named: "user")!, handler: { item in
            self.performSegue(withIdentifier: "showprof", sender: self)
//            let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .Alert)
//            alert.addAction(UIAlertAction(title: "Me too", style: .Default, handler: nil))
//            self.presentViewController(alert, animated: true, completion: nil)
            floaty.close()
        })
        floaty.addItem("Chat", icon: UIImage(named: "chatmsgnew")!, handler: { item in
            //            let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .Alert)
            //            alert.addAction(UIAlertAction(title: "Me too", style: .Default, handler: nil))
            //            self.presentViewController(alert, animated: true, completion: nil)
            floaty.close()
        })
        self.view.addSubview(floaty)
        GetAll( flag: true,completionHandler: { success in
            let hud1 = JGProgressHUD(style: .light)
            hud1.textLabel.text = "Loading..."
            
            hud1.progress = 0.5
            //hud.show(in: self, animated: true)
            hud1.show(in: self.view)
            // print(self.BarsArray.count)
            print("compdone")
            self.pubTable.reloadData()
            hud1.dismiss()

        })

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let floaty = Floaty()
        floaty.addItem("Add post", icon: UIImage(named: "addannoncenew")!, handler: { item in
            self.performSegue(withIdentifier: "addannonce", sender: self)
            //            let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .Alert)
            //            alert.addAction(UIAlertAction(title: "Me too", style: .Default, handler: nil))
            //            self.presentViewController(alert, animated: true, completion: nil)
            floaty.close()
        })
        floaty.addItem("Profile", icon: UIImage(named: "user")!, handler: { item in
            self.performSegue(withIdentifier: "showprof", sender: self)
            //            let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .Alert)
            //            alert.addAction(UIAlertAction(title: "Me too", style: .Default, handler: nil))
            //            self.presentViewController(alert, animated: true, completion: nil)
            floaty.close()
        })
        floaty.addItem("Chat", icon: UIImage(named: "chatmsgnew")!, handler: { item in
            //            let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .Alert)
            //            alert.addAction(UIAlertAction(title: "Me too", style: .Default, handler: nil))
            //            self.presentViewController(alert, animated: true, completion: nil)
            floaty.close()
        })
        self.view.addSubview(floaty)
        GetAll( flag: true,completionHandler: { success in
            let hud1 = JGProgressHUD(style: .light)
            hud1.textLabel.text = "Loading..."
            
            hud1.progress = 0.5
            //hud.show(in: self, animated: true)
            hud1.show(in: self.view)
            // print(self.BarsArray.count)
            print("compdone")
            self.pubTable.reloadData()
            hud1.dismiss()
            
        })
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let floaty = Floaty()
        floaty.addItem("Add post", icon: UIImage(named: "addannoncenew")!, handler: { item in
            self.performSegue(withIdentifier: "addannonce", sender: self)
            //            let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .Alert)
            //            alert.addAction(UIAlertAction(title: "Me too", style: .Default, handler: nil))
            //            self.presentViewController(alert, animated: true, completion: nil)
            floaty.close()
        })
        floaty.addItem("Profile", icon: UIImage(named: "user")!, handler: { item in
            self.performSegue(withIdentifier: "showprof", sender: self)
            //            let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .Alert)
            //            alert.addAction(UIAlertAction(title: "Me too", style: .Default, handler: nil))
            //            self.presentViewController(alert, animated: true, completion: nil)
            floaty.close()
        })
        floaty.addItem("Chat", icon: UIImage(named: "chatmsgnew")!, handler: { item in
            //            let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .Alert)
            //            alert.addAction(UIAlertAction(title: "Me too", style: .Default, handler: nil))
            //            self.presentViewController(alert, animated: true, completion: nil)
            floaty.close()
        })
        self.view.addSubview(floaty)
        GetAll( flag: true,completionHandler: { success in
            let hud1 = JGProgressHUD(style: .light)
            hud1.textLabel.text = "Loading..."
            
            hud1.progress = 0.5
            //hud.show(in: self, animated: true)
            hud1.show(in: self.view)
            // print(self.BarsArray.count)
            print("compdone")
            self.pubTable.reloadData()
            hud1.dismiss()
            
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        
        if fetching {
            count = AnnoncesArrayFiltred.count
        }
        else {
            count = AnnoncesArray.count
        }
        
        return count    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pubTable.dequeueReusableCell(withIdentifier: "cellAcc")
        let direction = cell?.viewWithTag(1) as? UILabel
         let date = cell?.viewWithTag(2) as? UILabel
        let carimg = cell?.viewWithTag(3)as? UIImageView
         let userimg = cell?.viewWithTag(4)as? UIImageView
         let nbrPlaces = cell?.viewWithTag(5) as? UILabel
         let prix = cell?.viewWithTag(6) as? UILabel
        var annonce : Dictionary<String , Any>
        if fetching {
            annonce = AnnoncesArrayFiltred[indexPath.row] as! Dictionary<String , Any>
        }
        else {
             annonce = AnnoncesArray[indexPath.row] as! Dictionary<String , Any>

        }
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "det" {
            //send parametre when we perform segue to details of the bar
            let barinfo = segue.destination as? DetailsViewController
            let indexPath = pubTable.indexPathForSelectedRow?.row
            var Annonce = AnnoncesArray[indexPath!] as! Dictionary<String , Any>
            barinfo?.nameimgcar = "http://marwen1994.alwaysdata.net/Carpooling/public/brahim/"+"\(Annonce["imageVoiture"] as! String)"+".jpeg"
            barinfo?.desc = (Annonce["Description"] as? String)!
            barinfo?.cartypename = (Annonce["type"] as? String)!
            barinfo?.userimgname =  "http://marwen1994.alwaysdata.net/Carpooling/public/brahim/"+"\(Annonce["imageuser"] as! String)"+".jpeg"
            barinfo?.date =  (Annonce["datedeplassement"] as? String)!
                barinfo?.prix =  (Annonce["prix"] as? String)!
             barinfo?.idannonce =  (Annonce["idAnnonce"] as? String)!
            barinfo?.destination = "\(Annonce["adresseDepart"] as! String)  --> \(Annonce["adresseArrive"] as! String)"
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "det", sender: self)
        
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
extension AcceuilViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        AnnoncesArrayFiltred = AnnoncesArray.filter({($0["adresseArrive"] as! String).lowercased().contains(searchText.lowercased())  })
        fetching = true
        if(searchText == "") {
fetching = false
            
        }
        self.pubTable.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        fetching = false
        searchbar.text = ""
        self.pubTable.reloadData()

        
    }
}
