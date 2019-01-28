//
//  FeedsViewController.swift
//  CARPOOLING
//
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit
import Cosmos
import Alamofire
import AlamofireImage
class FeedsViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    private let startRating:Double = 3.7
    var urlrate = "http://marwen1994.alwaysdata.net/Carpooling/public/Rating.php"
    var CommentArray = [AnyObject]()
    var userArray = [AnyObject]()
var urladdcomment = "http://marwen1994.alwaysdata.net/Carpooling/public/addcomment.php"
var urlcomment = "http://marwen1994.alwaysdata.net/Carpooling/public/getcomment.php"
    var rateval = String()
    var idannonce = ""
    var urlgetrate = "http://marwen1994.alwaysdata.net/Carpooling/public/getRate.php"

   
    var ratevalueis = String()
    var ratev = String()
    @IBOutlet weak var ratebtn: UIButton!
    @IBOutlet weak var ratingview: CosmosView!
    
    @IBOutlet weak var commenttxt: UITextField!
    
    @IBOutlet weak var commenttv: UITableView!
    
    var commenttab = [AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getRate()
        ratingview.didTouchCosmos = didTouchCosmos
        GetAll( flag: true,completionHandler: { success in
            // print(self.BarsArray.count)
            print("compdone")
            self.commenttv.reloadData()
        })
        
        ratingview.didFinishTouchingCosmos = didFinishTouchingCosmos
        // print("hello")
        
        ratingview.rating = startRating
        // Do any additional setup after loading the view.
    }
    
    private class func formatValue(_ value: Double) -> String {
        return String(format: "%.2f", value)
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commenttv.dequeueReusableCell(withIdentifier: "comment")
        let comment = cell?.viewWithTag(2) as? UILabel
         let userimgv = cell?.viewWithTag(1)as? UIImageView
        var Annonce = CommentArray[indexPath.row] as! Dictionary<String , Any>
        userArray = CommentArray[indexPath.row]["user"]as! [AnyObject]
         let imguserurl = "http://marwen1994.alwaysdata.net/Carpooling/public/brahim/"+"\(userArray[0]["image"] as! String)"+".jpeg"

        comment?.text = (Annonce["message"] as? String)!
        userimgv?.af_setImage(withURL: URL(string: imguserurl)!)

        return cell!
    }
   
    public func AddComments(flag:Bool, completionHandler: @escaping (Bool) -> Void ) {
        
        
        let parameters: Parameters=[
            "id_annonce":idannonce,
            "message":self.commenttxt.text!,
            "id_owner":UserDefaults.standard.string(forKey: "id")!,
            
            ]
        Alamofire.request(urladdcomment, method: .post, parameters: parameters).responseJSON
            {
                response in
                
                //    print(response)
                self.commenttxt.text = ""
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
    
    @IBAction func commentbtnclicked(_ sender: Any) {
        AddComments ( flag: true,completionHandler: { success in
            // print(self.BarsArray.count)
          print("comment added")
            self.GetAll( flag: true,completionHandler: { success in
                // print(self.BarsArray.count)
                print("refreshed")
                self.commenttv.reloadData()
            })
        })
     
       
    }
    private func didTouchCosmos(_ rating: Double) {
        ratingview.rating = Double(rating)
        // starratingbar.text = ""+"\(Int(rating))"
        //   print("ratingis" + "\(ratev)")
        ratev = String(Int(rating))
        // print(ratev)
        ratepub()
        self.dismiss(animated: true, completion: nil)

        //  ratepub(value: Int(rating))
        // rating.textColor = UIColor(red: 133/255, green: 116/255, blue: 154/255, alpha: 1)
    }
    
    private func didFinishTouchingCosmos(_ rating: Double) {
        ratingview.rating = Double(rating)
        ratingview.text = ""+"\(Int(rating))"
        ratevalueis = ""+"\(Int(rating))"
        
        // self.rating.text = ViewController.formatValue(rating)
        //ratingLabel.textColor = UIColor(red: 183/255, green: 186/255, blue: 204/255, alpha: 1)
    }
    private func updateRating() {
        let value = Double(ratingview.rating)
        ratingview.rating = value
        
        // ratepub(value: Int(value))
        
        
        
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
                    self.ratingview.rating = Double((valuerate[0]["value"]! as? String)!)!
                }
                
        }
        
        
    }
    
    
    func ratepub() {
        print(idannonce)
        print(ratev)


        let parameters: Parameters=[
            "id_annonce":idannonce,
            "id_user":UserDefaults.standard.string(forKey: "id")!,
            "value":ratev
        ]
        Alamofire.request(urlrate, method: .post, parameters: parameters).responseJSON
            {
                response in
                
                //    print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    //displaying the message in label
                    //let valres = jsonData.value(forKey: "response") as! String?
                    
                }
        }
        
    }
    public func GetAll(flag:Bool, completionHandler: @escaping (Bool) -> Void ) {
        
        
        let parameters: Parameters=[
            "id_annonce":idannonce,
            
            ]
        
        Alamofire.request(urlcomment, method: .post, parameters: parameters).responseJSON
            {
                response  in
                
                
                
                //getting the json value from the server
                let result = response.result
                if let dict = result.value as? Dictionary<String,AnyObject>{
                    print (dict)
                    self.CommentArray = dict["items"] as! [AnyObject]
                    
                }
                completionHandler(true)
                
        }
    }

    
    @IBAction func closebtnclicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)

    }
    
}
