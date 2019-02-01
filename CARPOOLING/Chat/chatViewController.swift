//
//  chatViewController.swift
//  CARPOOLING
//
//  Created by Sam on 01/02/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire
class chatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var  timer: Timer!
var urladdtext = "http://marwen1994.alwaysdata.net/Carpooling/public/addMessages.php"
    var chatArray = [AnyObject]()
var urlgetmessages = "http://marwen1994.alwaysdata.net/Carpooling/public/getMessages.php"
    
    var idget = ""

    @IBOutlet weak var chattxt: UITextField!
    @IBOutlet weak var tcchat: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
         timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(chatViewController.sayHello), userInfo: nil, repeats: true)
        GetAll( flag: true,completionHandler: { success in
            print(self.chatArray.count)
            self.tcchat.reloadData()
        })
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.timer?.invalidate()

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArray.count
    }
    @objc func sayHello()
    {
        GetAll( flag: true,completionHandler: { success in
            print(self.chatArray.count)
            self.tcchat.reloadData()
        })    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tcchat.dequeueReusableCell(withIdentifier: "chat", for: indexPath) as! chatTableViewCell
        print ( chatArray.count)
        var messages = chatArray[indexPath.row] as! Dictionary<String , Any>
        print(messages["message"] as! String)
        print(idget)
        print(messages["id_user_conn"] as! String)


        let imguserurlconnected = "http://marwen1994.alwaysdata.net/Carpooling/public/brahim/"+"\(messages["id_user_conn"] as! String)"+".jpeg"
        let imguserurlother = "http://marwen1994.alwaysdata.net/Carpooling/public/brahim/"+"\(idget)"+".jpeg"
        cell.imgotheruser.af_setImage(withURL: URL(string: imguserurlother)!)
        cell.imguserconnected.af_setImage(withURL: URL(string: imguserurlconnected)!)
        if messages["id_user_conn"] as! String == UserDefaults.standard.string(forKey: "id")! {
            cell.messageView.backgroundColor = UIColor(red:0.20, green:0.60, blue:0.86, alpha:0.8)
            cell.messagelbl.text = messages["message"] as! String
            cell.messagelbl.textColor = UIColor.white
            cell.imgotheruser.isHidden = true
            cell.imguserconnected.isHidden = false

        }
        else{
            cell.messageView.backgroundColor = UIColor(red:0.93, green:0.94, blue:0.95, alpha:0.8)
            cell.messagelbl.text = messages["message"] as! String
            cell.messagelbl.textColor = UIColor.darkText
            cell.imguserconnected.isHidden = true
            cell.imgotheruser.isHidden = false

        }
        
//        username?.text = (AlluserArray[0]["name"] as? String)!
//        userimgv?.af_setImage(withURL: URL(string: imguserurl)!)
        
        return cell
    }
    
    
    public func GetAll(flag:Bool, completionHandler: @escaping (Bool) -> Void ) {
        
        
        let parameters: Parameters=[
            "idconn":UserDefaults.standard.string(forKey: "id")!,
            "idget":idget,

            ]
        
        Alamofire.request(urlgetmessages, method: .post, parameters: parameters).responseJSON
            {
                response  in
                
                
                
                //getting the json value from the server
                let result = response.result
                if let dict = result.value as? Dictionary<String,AnyObject>{
                    print (dict)
                    self.chatArray = dict["items"] as! [AnyObject]
                    
                }
                completionHandler(true)
                
        }
    }

    public func AddMessage(flag:Bool, completionHandler: @escaping (Bool) -> Void ) {
        
        
        let parameters: Parameters=[
            "idget":idget,
            "message":self.chattxt.text!,
            "idconn":UserDefaults.standard.string(forKey: "id")!,
            
            ]
        Alamofire.request(urladdtext, method: .post, parameters: parameters).responseJSON
            {
                response in
                
                //    print(response)
              
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    
                    //displaying the message in label
                    let val = jsonData.value(forKey: "response") as! String?
                    print("commentaded")
                    
                }
                completionHandler(true)
                
        }
    }
   
    @IBAction func sendmsgisclicked(_ sender: UIButton) {
        AddMessage ( flag: true,completionHandler: { success in
            // print(self.BarsArray.count)
             self.chattxt.text = ""
            })
        
    }
}
