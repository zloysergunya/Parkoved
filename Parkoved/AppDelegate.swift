//
//  AppDelegate.swift
//  Parkoved
//
//  Created by Sergey Kotov on 25.09.2020.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("======= Директория приложения =======\n\(NSHomeDirectory())\n=============================\n")
        
        let currentVersion: UInt64 = 1
        let config = Realm.Configuration(
            schemaVersion: currentVersion,
            migrationBlock: { migration, oldSchemaVersion in
        }, deleteRealmIfMigrationNeeded: true)
        Realm.Configuration.defaultConfiguration = config
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: AuthVC(nibName: "AuthVC", bundle: nil))
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

