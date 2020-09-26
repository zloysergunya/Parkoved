//
//  AuthVC.swift
//  Parkoved
//
//  Created by Sergey Kotov on 26.09.2020.
//

import UIKit

class AuthVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var phoneField: RoundField!
    @IBOutlet weak var enterButton: RoundButton!
    @IBOutlet weak var changeNumberButton: UIButton!
    
    var step = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        step = 0
        restartScreen()
        hideInterface()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if AUTH_TOKEN != nil {
            let vc = TabBarController(nibName: "TabBarController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func hideInterface() {
        titleLabel.isHidden = AUTH_TOKEN != nil
        subTitleLabel.isHidden = AUTH_TOKEN != nil
        phoneField.isHidden = AUTH_TOKEN != nil
        enterButton.isHidden = AUTH_TOKEN != nil
        changeNumberButton.isHidden = true
    }
    
    func restartScreen() {
        if step == 0 {
            titleLabel.text = "Добро\nпожаловать!"
            subTitleLabel.text = "Введите свой номер телефона"
            phoneField.text = ""
            phoneField.placeholder = "+7"
            enterButton.setTitle("Отправить СМС", for: .normal)
            changeNumberButton.isHidden = true
        } else if step == 1 {
            titleLabel.text = "Код\nподтверждения"
            subTitleLabel.text = "Если код не пришел, то всё, не повезло"
            phoneField.text = ""
            phoneField.placeholder = "Введите код"
            enterButton.setTitle("Подтвердить", for: .normal)
            changeNumberButton.isHidden = false
        }
    }
    
    @IBAction func nextStep(_ sender: Any) {
        if phoneField.text?.count == 0 {
            phoneField.shake()
            return
        }
        if step == 0 {
            PHONE_NUMBER = phoneField.text?.applyPatternOnNumbers(pattern: "+###########", replacmentCharacter: "#")
            let params = ["phone": PHONE_NUMBER]
            authRegister(params as [String:Any])
        } else if step == 1 {
            let params = ["phone": PHONE_NUMBER,
                          "code": phoneField.text ?? ""]
            authConfirm(params as [String:Any])
        }
    }
    
    @IBAction func changeNumber(_ sender: Any) {
        step = 0
        restartScreen()
    }
}

extension AuthVC {
    func authRegister(_ params: [String: Any]) {
        HTTPRequest(SERVER_URL + "auth/request", params: params, completion: { data, status in
            if let success = (data?.json as? [String: Any])?["success"] as? Bool {
                if success {
                    self.step = 1
                    self.restartScreen()
                }
            }
        })
    }
    
    func authConfirm(_ params: [String: Any]) {
        HTTPRequest(SERVER_URL + "auth/confirm", params: params, completion: { data, status in
            if status < 399 {
                if let token = (data?.json as? [String: Any])?["token"] as? String {
                    AUTH_TOKEN = token
                    self.getUserInfo()
                    let vc = TabBarController(nibName: "TabBarController", bundle: nil)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        })
    }
    
    func getUserInfo() {
        let params = ["token": AUTH_TOKEN]
        HTTPRequest(SERVER_URL + "users/me", method: "GET", params: params, completion: { data, status in
            if status < 399 {
                if let uid = (data?.json as? [String: Any])?["uid"] as? String {
                    UID = uid
                }
            }
        })
    }
}

extension AuthVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if step == 0 {
            self.phoneField.text = self.phoneField.text?.applyPatternOnNumbers(pattern: "+# (###) ###-##-##", replacmentCharacter: "#")
        }
        return true
    }
}
