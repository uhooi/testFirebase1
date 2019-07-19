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
    private let disposeBag = DisposeBag()
    // RealtimeDatabaseに送るメッセージデータ
    var messages = [Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    func initView() {
        sendButton.addTarget(self, action: #selector(self.sendData), for: .touchUpInside)
        sendButton.layer.cornerRadius = 25
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.indicatorStyle = UIScrollView.IndicatorStyle.black
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.separatorStyle = .none
    }
    
    @objc func sendData() {
        // データ書き込み機能

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
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }

    @objc func exit(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}


