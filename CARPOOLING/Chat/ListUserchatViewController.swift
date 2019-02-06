//
//  ListUserchatViewController.swift
//  CARPOOLING
//
//  Created by Sam on 31/01/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class ListUserchatViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
 var UsersArray = [AnyObject]()
    var AlluserArray = [AnyObject]()
   // var  helloWorldTimer: Timer!

var urlallusers = "http://marwen1994.alwaysdata.net/Carpooling/public/messageList.php"
    @IBOutlet weak var tvchatuser: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        helloWorldTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ViewController.sayHello), userInfo: nil, repeats: true)
        
        GetAll( flag: true,completionHandler: { success in
            // print(self.BarsArray.count)
            self.tvchatuser.reloadData()
        })
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UsersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvchatuser.dequeueReusableCell(withIdentifier: "chatusers")
        let username = cell?.viewWithTag(2) as? UILabel
        let userimgv = cell?.viewWithTag(1)as? UIImageView
        var listUsers = UsersArray[indexPath.row] as! Dictionary<String , Any>
        self.AlluserArray = listUsers["user"]as! [AnyObject]
        let imguserurl = "http://marwen1994.alwaysdata.net/Carpooling/public/brahim/"+"\(AlluserArray[0]["image"] as! String)"+".jpeg"
        
        username?.text = (AlluserArray[0]["name"] as? String)!
        userimgv?.af_setImage(withURL: URL(string: imguserurl)!)
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "tomessages", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tomessages" {
            //send parametre when we perform segue to details of the bar
            let messages = segue.destination as? chatViewController
            let indexPath = tvchatuser.indexPathForSelectedRow?.row
            var Annonce = UsersArray[indexPath!] as! Dictionary<String , Any>
            messages?.idget = Annonce["id_user"] as! String
           
        }
    }
    
    public func GetAll(flag:Bool, completionHandler: @escaping (Bool) -> Void ) {
        
        
        let parameters: Parameters=[
            "idconn":UserDefaults.standard.string(forKey: "id")!,
            
            ]
        
        Alamofire.request(urlallusers, method: .post, parameters: parameters).responseJSON
            {
                response  in
                
                
                
                //getting the json value from the server
                let result = response.result
                if let dict = result.value as? Dictionary<String,AnyObject>{
                    print (dict)
                    self.UsersArray = dict["items"] as! [AnyObject]
                    
                }
                completionHandler(true)
                
        }
    }

  

}
