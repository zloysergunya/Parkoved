//
//  Service.swift
//  Parkoved
//
//  Created by Sergey Kotov on 26.09.2020.
//

import RealmSwift

class Service: Object, Decodable {
    
    override static func primaryKey() -> String? {
        return "sid"
    }
    
    @objc dynamic var sid = String()
    @objc dynamic var name = String()
    @objc dynamic var workingHours = String()
    @objc dynamic var ageLimit = Int()
    
    enum CodingKeys: String, CodingKey {
        case sid = "sid"
        case name = "name"
        case workingHours = "workingHours"
        case ageLimit = "ageLimit"
    }
    
    required convenience init(_ dictionary: [String:Any]) {
        self.init()
        sid = dictionary["sid"] as? String ?? ""
        name = dictionary["name"] as? String ?? ""
        workingHours = dictionary["workingHours"] as? String ?? ""
        ageLimit = dictionary["ageLimit"] as? Int ?? Int()
    }
}
