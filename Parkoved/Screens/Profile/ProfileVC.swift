//
//  ProfileVC.swift
//  Parkoved
//
//  Created by Sergey Kotov on 25.09.2020.
//

import UIKit
import RealmSwift

class ProfileVC: UIViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    private func setupUI() {
        let realM = try! Realm()
        if let user = realM.objects(User.self).first {
            userName.text = user.name
            userEmail.text = user.email
        }
    }

    @IBAction func exitToAuth(_ sender: Any) {
        let realM = try! Realm()
        try! realM.write {
            realM.deleteAll()
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
}
