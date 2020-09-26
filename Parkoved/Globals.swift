//
//  Globals.swift
//  Parkoved
//
//  Created by Sergey Kotov on 26.09.2020.
//

import Foundation
import UIKit

var PHONE_NUMBER: String? {
    set { if let v = newValue { UserDefaults.standard.setValue(v, forKey: "phoneNumber") }
          else { UserDefaults.standard.removeObject(forKey: "phoneNumber") }}
    get { return UserDefaults.standard.string(forKey: "phoneNumber") }
}

var SERVER_URL: String {
    set { UserDefaults.standard.setValue(newValue, forKey: "URL") }
    get { return UserDefaults.standard.string(forKey: "URL") ?? "https://parkoved.herokuapp.com/api/"}
}

var AUTH_TOKEN: String? {
    set { if let v = newValue { UserDefaults.standard.setValue(v, forKey: "authToken") }
          else { UserDefaults.standard.removeObject(forKey: "authToken") }}
    get { return UserDefaults.standard.string(forKey: "authToken") }
}

var UID: String? {
    set { if let v = newValue { UserDefaults.standard.setValue(v, forKey: "uid") }
          else { UserDefaults.standard.removeObject(forKey: "uid") }}
    get { return UserDefaults.standard.string(forKey: "uid") }
}

var APP : (bundle: String, version: String, build: String, model: String, os: String, name: String) = {
    let bundle = Bundle.main.bundleIdentifier!
    let dictionary = Bundle.main.infoDictionary!
    let version = dictionary["CFBundleShortVersionString"] as? String ?? "Unknown version"
    let build = dictionary["CFBundleVersion"] as? String ?? "Unknown build"
    let model = UIDevice.modelName
    let os = UIDevice.current.systemVersion
    let name = dictionary["CFBundleName"] as? String ?? "Unknown name"
    return (bundle, version, build, model, os, name)
}()
