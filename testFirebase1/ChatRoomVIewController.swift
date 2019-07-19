//
//  ChatRoomViewController.swift
//  testFirebase1
//
//  Created by がーたろ on 2019/07/09.
//  Copyright © 2019 がーたろ. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import RxCocoa
import RxSwift



class ChatRoomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    var databaseRef:DatabaseReference!
    var messages = [Any]()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    func initView() {
        self.sendButton.layer.cornerRadius = 25
        self.messageTextField.layer.cornerRadius = 5
        self.title = "TUB"
        self.navigationController?.navigationBar.titleTextAttributes = [
            // 文字の色
            .foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Futura", size: 30)!
        ]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "退出", style: .plain, target: self, action: #selector(exit(_:)))
        sendButton.addTarget(self, action: #selector(self.sendData), for: .touchUpInside)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = true
        tableView.indicatorStyle = UIScrollView.IndicatorStyle.black
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        tableView.transform = __CGAffineTransformMake(1, 0, 0, -1, 0, 0)
        databaseRef = Database.database().reference()
        databaseRef.observe(.childAdded, with: { snapshot in
            if let obj = snapshot.value as? [String : AnyObject], let name = obj["name"] as? String, let message = obj["message"] {
                self.messages.insert(obj, at: 0)
                self.tableView.reloadData()
            }
        })
        // バリデーション
        validTxtField(textField: messageTextField)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.separatorStyle = .none
        sendButton.isEnabled = false
    }
    
    @objc func sendData() {
        if let message = messageTextField.text {
            let messageData = ["name": UserDefaults.standard.string(forKey: "name"), "message": message]
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

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell
        let dictionary = messages[indexPath.row] as! [String: AnyObject]
        cell?.messageLabel?.text = dictionary["message"] as? String
        cell?.nameLabel?.text = dictionary["name"] as? String
        if cell?.nameLabel?.text == UserDefaults.standard.string(forKey: "name") {
            cell?.messageLabel.backgroundColor = UIColor(hex: "D7003E")
            cell?.messageLabel.textColor = UIColor(hex: "FFFFFF")
            cell?.iconImg.image = UIImage(named: "TUB_Red")
        }
        cell!.transform = __CGAffineTransformMake(1, 0, 0, -1, 0, 0)
        
        
        return cell!
    }
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    //退出時のアラート
    func showNotAnswerDialog() {
        let alert: UIAlertController = UIAlertController(title: "退出", message: "現在のルームから退出しますか？", preferredStyle: .alert)
        // 決定ボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "退出", style: .default, handler: { (_: UIAlertAction!) -> Void in
            self.navigationController?.popViewController(animated: true)
        })
        // キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: { (_: UIAlertAction!) -> Void in
        })
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        alert.preferredAction = defaultAction
        present(alert, animated: true, completion: nil)
        
    }

    @objc func exit(_ sender: UIBarButtonItem) {
        showNotAnswerDialog()
    }
    
    // 文字数チェック
    private func changeLoginEnabled() {
        if messageTextField.text!.count > 0{
            // ボタンの活性状態
            sendButton.isEnabled = true
        } else {
            sendButton.isEnabled = false
        }
        
    }
    
    func validTxtField(textField: UITextField) {
        // textの変更を検知する
        textField.rx.text.subscribe(onNext: { _ in
            print(textField.text!.count)
            
            // チェック関数の呼び出し
            self.changeLoginEnabled()
        }).disposed(by: disposeBag)
    }
    



}


