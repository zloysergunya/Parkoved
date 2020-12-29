//
//  UIViewController.swift
//  Parkoved
//
//  Created by Sergey Kotov on 26.09.2020.
//

import UIKit

extension UIViewController {
    func popAllViewControllers(animated: Bool, completion: (()->())?) {
        var count = 0
        if let c = self.navigationController?.viewControllers.count {
            count = c
        }
        if count > 1 {
            self.navigationController?.popViewController(animated: animated)
            if let handler = completion {
                handler()
            }
        } else {
            dismiss(animated: animated, completion: completion)
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func dialog(title: String,
                message: String,
                default access: String? = nil,
                cancel: String? = "Закрыть",
                onAgree: ((UIAlertAction)->Void)? = nil,
                onCancel: ((UIAlertAction)->Void)? = nil
    ) {
        if access?.isEmpty ?? true && cancel?.isEmpty ?? true { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if let access = access {
            alert.addAction(UIAlertAction(title: access, style: .default, handler: onAgree))
        }
        if let cancel = cancel {
            alert.addAction(UIAlertAction(title: cancel, style: .cancel, handler: onCancel))
        }
        self.present(alert, animated: true, completion: nil)
    }
}
