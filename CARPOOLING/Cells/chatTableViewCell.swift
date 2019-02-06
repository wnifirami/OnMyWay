//
//  chatTableViewCell.swift
//  CARPOOLING
//
//  Created by Sam on 01/02/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit

class chatTableViewCell: UITableViewCell {

    @IBOutlet weak var imgotheruser: UIImageView!
    
    @IBOutlet weak var imguserconnected: UIImageView!
    
    @IBOutlet weak var messageView: UIView!
    
    @IBOutlet weak var messagelbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
