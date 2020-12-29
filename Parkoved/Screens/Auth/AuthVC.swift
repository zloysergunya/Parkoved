//
//  AuthVC.swift
//  Parkoved
//
//  Created by Sergey Kotov on 26.09.2020.
//

import UIKit
import GoogleSignIn
import Firebase
import RealmSwift

class AuthVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateUI()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupUI() {
        setupGoogleSingIn()
    }
    
    private func updateUI() {
        hideInterface()
    }
    
    func hideInterface() {
        let realM = try! Realm()
        if realM.objects(User.self).first != nil {
            titleLabel.isHidden = true
            googleSignInButton.isHidden = true
            let vc = TabBarController(nibName: "TabBarController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            titleLabel.isHidden = false
            googleSignInButton.isHidden = false
        }
    }
}

extension AuthVC: GIDSignInDelegate {
    private func setupGoogleSingIn() {
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    @IBAction func googleSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            saveUser(user)
            let vc = TabBarController(nibName: "TabBarController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        guard let authentication = user?.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("Пользователь успешно авторизировался в Firebase")
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Пользователь отключился")
    }
    
    private func saveUser(_ googleUser: GIDGoogleUser) {
        let realM = try! Realm()
        try! realM.write {
            let dict = ["uuid": googleUser.userID!,
                        "name": googleUser.profile.name ?? "",
                        "email": googleUser.profile.email ?? "",
                        "token": googleUser.authentication.idToken!,
                        "photo": "\(googleUser.profile.imageURL(withDimension: 500)!)"]
            realM.add(User(dict))
        }
    }
}
