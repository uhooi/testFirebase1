//
//  TableViewCell.swift
//  testFirebase1
//
//  Created by がーたろ on 2019/07/14.
//  Copyright © 2019 がーたろ. All rights reserved.
//

import UIKit

final class ChatTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet private var nameLabel: UITextField!
    @IBOutlet private var messageTextField: UITextField!
    @IBOutlet private var iconImageView: UIImageView!
    
    // MARK: Internal Methods
    
    func setup(name: String?, message: String?, isMyself: Bool) {
        self.nameLabel.text = name
        self.messageTextField.text = message
        if isMyself {
            self.messageTextField.backgroundColor = UIColor(hex: "D7003E")
            self.messageTextField.textColor = UIColor(hex: "FFFFFF")
            self.iconImageView.image = UIImage(named: "TUB_Red")
        } else {
            self.messageTextField.backgroundColor = UIColor(hex: "FFFFFF")
            self.messageTextField.textColor = UIColor(hex: "000000")
            self.iconImageView.image = UIImage(named: "TUB_Blue")
        }
    }
    
}
