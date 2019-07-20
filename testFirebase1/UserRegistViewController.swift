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

final class UserRegistViewController: UIViewController {

    // MARK: Properties
    
    private let disposeBag = DisposeBag()
    
    // MARK: IBOutlets
    
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var sendButton: UIButton!
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.nameTextField.text = ""
        UserDefaults.standard.removeObject(forKey: "name")
    }
    
    // MARK: Private Methods
    
    private func initView() {
        configureNavigationBar()
        configureSendButton()
        changeLoginEnabled()
        validTextField(textField: self.nameTextField)
    }
    
    private func configureNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Futura", size: 30)!]
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    private func configureSendButton() {
        sendButton.addTarget(self, action: #selector(self.moveToChat), for: .touchUpInside)
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.setTitleColor(.gray, for: .disabled)
    }
    
    private func changeLoginEnabled() {
        if nameTextField.text?.isEmpty == false {
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
    
    @objc private func moveToChat() {
        UserDefaults.standard.set(nameTextField.text, forKey: "name")
        let storyboard = UIStoryboard(name: "ChatRoom", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ChatRoom")
        show(viewController, sender: nil)
    }

}
