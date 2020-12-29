//
//  AppDelegate.swift
//  Parkoved
//
//  Created by Sergey Kotov on 25.09.2020.
//

import UIKit
import RealmSwift
import Firebase
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let notificationCenter = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("======= Директория приложения =======\n\(NSHomeDirectory())\n=============================\n")
        
        FirebaseApp.configure()
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID

        let currentVersion: UInt64 = 1
        let config = Realm.Configuration(
            schemaVersion: currentVersion,
            migrationBlock: { migration, oldSchemaVersion in
            }, deleteRealmIfMigrationNeeded: true)
        Realm.Configuration.defaultConfiguration = config
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: AuthVC(nibName: "AuthVC", bundle: nil))
//        window?.rootViewController = UINavigationController(rootViewController: TabBarController(nibName: "TabBarController", bundle: nil))
        window?.makeKeyAndVisible()
        
        initNotificationCenter()
        notifyForEnterPark()
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
    -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }
}

extension AppDelegate {
    func initNotificationCenter() {
        notificationCenter.delegate = self
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: options) { (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
    }
    
    func notifyForEnterPark() {
        let content = UNMutableNotificationContent()
        content.title = "Добро пожаловать в Центральный парк!"
        content.body = "Проверьте карту - там есть специальное предложение для вас 😉"
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let identifier = "enterNotify"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        makeNotifyRequest(request)
    }
    
    func makeNotifyRequest(_ request: UNNotificationRequest) {
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}
