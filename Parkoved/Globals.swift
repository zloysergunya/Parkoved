//
//  Globals.swift
//  Parkoved
//
//  Created by Sergey Kotov on 26.09.2020.
//

import Foundation
import UIKit

var PHONE_NUMBER : String? {
    set { if let v = newValue { UserDefaults.standard.setValue(v, forKey: "phoneNumber") }
          else { UserDefaults.standard.removeObject(forKey: "phoneNumber") }}
    get { return UserDefaults.standard.string(forKey: "phoneNumber") }
}
