//
//  FrameVC.swift
//  Parkoved
//
//  Created by Sergey Kotov on 25.09.2020.
//

import UIKit
import RealmSwift

class FrameVC: UIViewController {
    
    let realM = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func dialog(title: String,
                message: String,
                default access: String? = nil,
                cancel: String? = "Закрыть",
                onAgree: ((UIAlertAction)->Void)? = nil,
                onCancel: ((UIAlertAction)->Void)? = nil
    ) {
        if access?.isEmpty ?? true && cancel?.isEmpty ?? true { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert) // Создаем диалоговое окно
        if let access = access {
            alert.addAction(UIAlertAction(title: access, style: .default, handler: onAgree))
        }
        if let cancel = cancel {
            alert.addAction(UIAlertAction(title: cancel, style: .cancel, handler: onCancel))
        }
        self.present(alert, animated: true, completion: nil) //
    }
}
