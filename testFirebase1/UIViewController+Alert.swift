//
//  UIViewController+Alert.swift
//  testFirebase1
//
//  Created by 川口真央 on 2019/07/20.
//  Copyright © 2019 がーたろ. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: Internal Methods

    func showAlert(title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        present(alert, animated: true)
    }
    
}
