//
//  Data.swift
//  Parkoved
//
//  Created by Sergey Kotov on 26.09.2020.
//


import Foundation

extension Data {
    var json: Any? {
        get {
            let serialize: Any?
            do {
                serialize = try JSONSerialization.jsonObject(with: self, options: [])
            }
            catch {
                return nil
            }
            return serialize
        }

    }
    

}
