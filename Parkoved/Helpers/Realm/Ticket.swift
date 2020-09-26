//
//  Ticket.swift
//  Parkoved
//
//  Created by Sergey Kotov on 26.09.2020.
//

import RealmSwift

class Ticket: Object, Decodable {
    
    override static func primaryKey() -> String? {
        return "tid"
    }
    
    @objc dynamic var tid = String()
    @objc dynamic var service = String()
    @objc dynamic var uses = Int()
    @objc dynamic var isForChild = Bool()
    @objc dynamic var owner = String()
    @objc dynamic var expiresAt = Int64()
    @objc dynamic var createdAt = Int64()
    
    enum CodingKeys: String, CodingKey {
        case tid = "tid"
        case service = "service"
        case uses = "uses"
        case isForChild = "isForChild"
        case owner = "owner"
        case expiresAt = "expiresAt"
        case createdAt = "createdAt"
    }
    
    required convenience init(_ dictionary: [String:Any]) {
        self.init()
        tid = dictionary["tid"] as? String ?? ""
        service = dictionary["service"] as? String ?? ""
        uses = dictionary["uses"] as? Int ?? Int()
        isForChild = dictionary["isForChild"] as? Bool ?? false
        owner = dictionary["owner"] as? String ?? ""
        expiresAt = dictionary["expiresAt"] as? Int64 ?? Int64()
        createdAt = dictionary["createdAt"] as? Int64 ?? Int64()
    }
}
