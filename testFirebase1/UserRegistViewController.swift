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
    
    func initView() {
        // 見た目
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
    
    // チャット画面から戻ってきた時にろユーザー情報を解錠する
    override func viewWillAppear(_ animated: Bool) {
    }
    
    @objc func moveToChat() {
        // UserDefaultを使ってチャット画面にログイン名を登録する
        
        let storyboard: UIStoryboard = UIStoryboard(name: "ChatRoom",bundle: nil)
        let viewController: UIViewController = storyboard.instantiateViewController(withIdentifier: "ChatRoom")
        show(viewController, sender: nil)
    }
    

}
