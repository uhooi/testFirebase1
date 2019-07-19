//
//  ViewController.swift
//  testFirebase1
//
//  Created by がーたろ on 2019/07/09.
//  Copyright © 2019 がーたろ. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet var messageTextField: UITextField!
    
    @IBOutlet var tableView: UITableView!
    
    var databaseRef:DatabaseReference!
    var messages = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = true
        tableView.indicatorStyle = UIScrollView.IndicatorStyle.black
//        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")

        databaseRef = Database.database().reference()
//        readFbData()
        
        databaseRef.observe(.childAdded, with: { snapshot in
            if let obj = snapshot.value as? [String : AnyObject], let name = obj["name"] as? String, let message = obj["message"] {
                self.messages.insert(obj, at: 0)
                self.tableView.reloadData()
                
//                let currentText = self.textView.text
//                self.textView.text = (currentText ?? "") + "\n\(name) : \(message)"
            }
        })
        
        

    }
    
//    func readFbData() {
//
//        databaseRef.observe(.childAdded, with: { snapshot in
//            if let obj = snapshot.value as? [String : AnyObject], let name = obj["name"] as? String, let message = obj["message"] {
//                let currentText = self.textView.text
//                self.textView.text = (currentText ?? "") + "\n\(name) : \(message)"
//            }
//        })
//    }
//
    func sendData() {
//        if let name = nameTextField.text, let message = messageTextField.text {
        if let message = messageTextField.text {
            let messageData = ["name": "ばなな", "message": message]
            databaseRef.childByAutoId().setValue(messageData)
            
            messageTextField.text = ""
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    
    @IBAction func sendBtn(_ sender: Any) {
        sendData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell (
            withIdentifier: "cell",
            for: indexPath as IndexPath)
        let dictionary = messages[indexPath.row] as! [String: AnyObject]
        
        cell.textLabel?.text = dictionary["message"] as? String
        
        
        
        
        return cell
    }
    
    
    
    
    
    
//    func sendData() {
////        if let name = nameTextField.text, let message = messageTextField.text {
//        let name: String = "testName"
//        let message: String = "testMessage"
//            let messageData = ["name": name, "message": message]
//
////        databaseRef = Database.database().reference()
//        databaseRef.childByAutoId().setValue(messageData)
//
////            textView.text = ""
////        }
//    }


}


