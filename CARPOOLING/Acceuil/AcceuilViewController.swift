//
//  AcceuilViewController.swift
//  CARPOOLING
//
//  Created by Sam on 20/01/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit

class AcceuilViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    @IBOutlet weak var pubTable: UITableView!
    
    @IBOutlet weak var searchbar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }

   

}
