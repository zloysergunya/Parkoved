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
    @objc dynamic var price = Int()
    @objc dynamic var imageURL = String()
    @objc dynamic var serviceDescription = String()
    
    enum CodingKeys: String, CodingKey {
        case sid = "sid"
        case name = "name"
        case workingHours = "workingHours"
        case ageLimit = "ageLimit"
        case price = "price"
        case imageURL = "imageURL"
        case serviceDescription = "serviceDescription"
    }
    
    required convenience init(_ dictionary: [String:Any]) {
        self.init()
        sid = dictionary["sid"] as? String ?? ""
        name = dictionary["name"] as? String ?? ""
        workingHours = dictionary["workingHours"] as? String ?? ""
        ageLimit = dictionary["ageLimit"] as? Int ?? Int()
        price = dictionary["price"] as? Int ?? Int()
        imageURL = dictionary["imageURL"] as? String ?? ""
        serviceDescription = dictionary["serviceDescription"] as? String ?? "Нет описания"
    }
}
