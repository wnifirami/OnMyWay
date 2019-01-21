//
//  AcceuilTableViewCell.swift
//  CARPOOLING
//
//  Created by Sam on 20/01/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit

class AcceuilTableViewCell: UITableViewCell {

    @IBOutlet weak var datecircuitlbl: UILabel!
    @IBOutlet weak var circuitlbl: UILabel!
    @IBOutlet weak var carimg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func sendRequestclicked(_ sender: UIButton) {
    }
}
