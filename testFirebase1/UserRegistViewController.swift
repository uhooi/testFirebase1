//
//  UserRegistViewController.swift
//  testFirebase1
//
//  Created by がーたろ on 2019/07/16.
//  Copyright © 2019 がーたろ. All rights reserved.
//

import UIKit

class UserRegistViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var sendButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.layer.cornerRadius = 5
        self.sendButton.layer.cornerRadius = 25
        self.title = "TUB"
        self.navigationController?.navigationBar.titleTextAttributes = [
            
            // 文字の色
            .foregroundColor: UIColor.white,
            
            NSAttributedString.Key.font: UIFont(name: "Futura", size: 30)!
        ]
        self.navigationController?.navigationBar.tintColor = .white
        sendButton.addTarget(self, action: #selector(self.moveToChat), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.nameTextField.text = ""
    }
    
    
    
    
    @objc func moveToChat() {
        
        UserDefaults.standard.removeObject(forKey: "name")

        UserDefaults.standard.set(nameTextField.text, forKey: "name")

        let storyboard: UIStoryboard = UIStoryboard(name: "ChatRoom",bundle: nil)
        let viewController: UIViewController = storyboard.instantiateViewController(withIdentifier: "ChatRoom")
        show(viewController, sender: nil)
    }

}
