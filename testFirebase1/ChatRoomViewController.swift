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

final class ChatRoomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    // MARK: Properties
    
    private var databaseRef: DatabaseReference!
    private let disposeBag = DisposeBag()
    private var messages: [Any] = []
    
    // MARK: IBOutlets
    
    @IBOutlet private var sendButton: UIButton!
    @IBOutlet private var messageTextField: UITextField!
    @IBOutlet private var tableView: UITableView!
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.separatorStyle = .none
        sendButton.isEnabled = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        let dictionary = messages[indexPath.row] as! [String: AnyObject]
        cell.messageLabel?.text = dictionary["message"] as? String
        cell.nameLabel?.text = dictionary["name"] as? String
        if cell.nameLabel?.text == UserDefaults.standard.string(forKey: "name") {
            cell.messageLabel.backgroundColor = UIColor(hex: "D7003E")
            cell.messageLabel.textColor = UIColor(hex: "FFFFFF")
            cell.iconImg.image = UIImage(named: "TUB_Red")
        }
        cell.transform = __CGAffineTransformMake(1, 0, 0, -1, 0, 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76.0
    }
    
    // MARK: Private Methods
    
    private func initView() {
        configureNavigationBar()
        configureSendButton()
        configureTableView()
        readChatData()
        validTextField(textField: messageTextField)
    }
    
    private func configureNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Futura", size: 30)!]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "退出", style: .plain, target: self, action: #selector(exit(_:)))
    }
    
    private func configureSendButton() {
        sendButton.addTarget(self, action: #selector(self.sendChatData), for: .touchUpInside)
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.setTitleColor(.gray, for: .disabled)
    }
    
    private func configureTableView() {
        tableView.indicatorStyle = UIScrollView.IndicatorStyle.black
        tableView.transform = __CGAffineTransformMake(1, 0, 0, -1, 0, 0) // テーブルビューを反転する
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    private func readChatData() {
        databaseRef = Database.database().reference()
        databaseRef.observe(.childAdded) { snapshot in
            if let obj = snapshot.value as? [String: AnyObject], obj["name"] as? String != nil, obj["message"] as? String != nil {
                self.messages.insert(obj, at: 0)
                self.tableView.reloadData()
            }
        }
    }
    
    private func showNotAnswerDialog() {
        let defaultAction = UIAlertAction(title: "退出", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { _ in
        }
        showAlert(title: "退出", message: "現在のルームから退出しますか？", actions: [defaultAction, cancelAction])
    }
    
    private func changeLoginEnabled() {
        if messageTextField.text?.isEmpty == false {
            sendButton.isEnabled = true
            sendButton.backgroundColor = UIColor(hex: "D7003E")
        } else {
            sendButton.isEnabled = false
            sendButton.backgroundColor = UIColor(hex: "801a2e")
        }
    }
    
    private func validTextField(textField: UITextField) {
        textField.rx.text.subscribe(onNext: { _ in
            self.changeLoginEnabled()
        }).disposed(by: disposeBag)
    }
    
    @objc private func sendChatData() {
        if let message = messageTextField.text {
            let messageData = ["name": UserDefaults.standard.string(forKey: "name"), "message": message]
            databaseRef.childByAutoId().setValue(messageData)
            messageTextField.text = ""
            changeLoginEnabled()
        }
    }
    
    @objc private func exit(_ sender: UIBarButtonItem) {
        showNotAnswerDialog()
    }

}
