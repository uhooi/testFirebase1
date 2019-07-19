//
//  TableViewCell.swift
//  testFirebase1
//
//  Created by がーたろ on 2019/07/14.
//  Copyright © 2019 がーたろ. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UITextField!
    @IBOutlet var messageLabel: UITextField!
    
    @IBOutlet var iconImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.messageLabel.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
