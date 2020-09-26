//
//  ProfileVC.swift
//  Parkoved
//
//  Created by Sergey Kotov on 25.09.2020.
//

import UIKit

class ProfileVC: FrameVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func exitToAuth(_ sender: Any) {
        PHONE_NUMBER = nil
        self.navigationController?.popToRootViewController(animated: true)
    }
}
