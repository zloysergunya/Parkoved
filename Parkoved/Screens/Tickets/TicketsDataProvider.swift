//
//  TicketsDataProvider.swift
//  Parkoved
//
//  Created by Sergey Kotov on 21.12.2020.
//

import RealmSwift

class TicketsDataProvider {
    let realM = try! Realm()
    
    func getTickets() -> Results<Ticket> {
        return realM.objects(Ticket.self)
    }
    
    func getServices() -> Results<Service> {
        return realM.objects(Service.self)
    }
    
    func getServiceById(_ sid: String) -> Service? {
        return realM.objects(Service.self).filter("sid == %@", sid).first
    }
    
    func updateServices(completion: @escaping () -> ()) {
        let params = ["token": AUTH_TOKEN,
                      "park": "stringstringstri"]
        HTTPRequest(SERVER_URL + "services/", method: "GET", params: params, completion: { data, status in
            completion()
            if status < 399 {
                if let json = data?.json as? [[String:Any]] {
                    self.saveServices(json)
                    completion()
                }
            }
        })
    }
    
    private func saveServices(_ dict: [[String:Any]]) {
        try! realM.write {
            dict.forEach { service in
                realM.add(Service(service), update: .modified)
            }
        }
    }
    
    func updateTickets(completion: @escaping () -> ()) {
        let params = ["token": AUTH_TOKEN]
        HTTPRequest(SERVER_URL + "tickets/", method: "GET", params: params, completion: { data, status in
            completion()
            if status < 399 {
                if let json = data?.json as? [[String:Any]] {
                    self.saveTickets(json)
                    completion()
                }
            }
        })
    }
    
    
    
    private func saveTickets(_ dict: [[String:Any]]) {
        try! realM.write {
            dict.forEach { ticket in
                realM.add(Ticket(ticket), update: .modified)
            }
        }
    }
}
