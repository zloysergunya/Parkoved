//
//  URLResponse.swift
//  Parkoved
//
//  Created by Sergey Kotov on 26.09.2020.
//

import CoreData

extension URLResponse {
    var getStatus: Int? {
        get {
            if let httpResponse = self as? HTTPURLResponse {
                return httpResponse.statusCode
            }
            return nil
        }
    }
}
