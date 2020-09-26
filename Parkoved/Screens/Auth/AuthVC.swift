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
//        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.backgroundColor = .white
        hideInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        step = 0
        restartScreen()
        hideInterface()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if PHONE_NUMBER != nil {
            let vc = TabBarController(nibName: "TabBarController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func hideInterface() {
        titleLabel.isHidden = PHONE_NUMBER != nil
        subTitleLabel.isHidden = PHONE_NUMBER != nil
        phoneField.isHidden = PHONE_NUMBER != nil
        enterButton.isHidden = PHONE_NUMBER != nil
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
            step = 1
        } else if step == 1 {
            let vc = TabBarController(nibName: "TabBarController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: true, completion: nil)
        }
        restartScreen()
    }
    
    @IBAction func changeNumber(_ sender: Any) {
        step = 0
        restartScreen()
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
