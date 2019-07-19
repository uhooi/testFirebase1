//
//  UserRegistViewController.swift
//  testFirebase1
//
//  Created by がーたろ on 2019/07/16.
//  Copyright © 2019 がーたろ. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class UserRegistViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var sendButton: UIButton!
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.nameTextField.text = ""
    }
    
    func initView() {
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
        validTxtField(textField: nameTextField)
    }
    
    @objc func moveToChat() {
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.set(nameTextField.text, forKey: "name")
        let storyboard: UIStoryboard = UIStoryboard(name: "ChatRoom",bundle: nil)
        let viewController: UIViewController = storyboard.instantiateViewController(withIdentifier: "ChatRoom")
        show(viewController, sender: nil)
    }
    
    private func changeLoginEnabled() {
        if nameTextField.text!.count > 0{
            // ボタンの活性状態
            sendButton.isEnabled = true
            sendButton.backgroundColor = UIColor(hex: "D7003E")
            sendButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            sendButton.isEnabled = false
            sendButton.backgroundColor = UIColor(hex: "801a2e")
            sendButton.setTitleColor(UIColor.gray, for: .normal)

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
