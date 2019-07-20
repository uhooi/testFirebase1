//
//  UIView+Border.swift
//  testFirebase1
//
//  Created by uhooi on 2019/07/20.
//  Copyright © 2019 がーたろ. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: Properties
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return self.layer.borderColor.map { UIColor(cgColor: $0) }
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.clipsToBounds = newValue > 0
        }
    }
    
}
