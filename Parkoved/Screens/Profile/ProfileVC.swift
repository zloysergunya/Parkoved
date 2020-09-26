//
//  ProfileVC.swift
//  Parkoved
//
//  Created by Sergey Kotov on 25.09.2020.
//

import UIKit

class ProfileVC: FrameVC {

    @IBOutlet weak var phoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let phone = PHONE_NUMBER {
            phoneLabel.text = phone.applyPatternOnNumbers(pattern: "+# (###) ###-##-##", replacmentCharacter: "#")
        } else {
            phoneLabel.text = "Нет номера"
        }
        
    }

    @IBAction func exitToAuth(_ sender: Any) {
        PHONE_NUMBER = nil
        AUTH_TOKEN = nil
        UID = nil
        self.navigationController?.popToRootViewController(animated: true)
    }
}
