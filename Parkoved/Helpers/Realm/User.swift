//
//  User.swift
//  Parkoved
//
//  Created by Sergey Kotov on 23.12.2020.
//

import RealmSwift

class User: Object, Decodable {
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
    @objc dynamic var uuid = String()
    @objc dynamic var name = String()
    @objc dynamic var email = String()
    @objc dynamic var token = String()
    @objc dynamic var photo: String?
    
    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case name = "name"
        case email = "email"
        case token = "token"
        case photo = "photo"
    }
    
    required convenience init(_ dictionary: [String:Any]) {
        self.init()
        uuid = dictionary["uuid"] as! String
        name = dictionary["name"] as? String ?? "Нет данных"
        email = dictionary["email"] as? String ?? "Нет данных"
        token = dictionary["token"] as! String
        photo = dictionary["photo"] as? String
    }
}

