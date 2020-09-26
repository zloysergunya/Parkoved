//
//  HTTPRequest.swift
//  Parkoved
//
//  Created by Sergey Kotov on 26.09.2020.
//

import RealmSwift

func HTTPRequest(_ url: String = SERVER_URL,
                     method: String = "JSON",
                     params: [String:Any?] = [:],
                     constants: [String:Any?] = [:],
                     completion: @escaping (Data?, _ status: Int) -> Void) {
    var urn: String = ""
    var timeout = 15.0
    let body = NSMutableData()
    let values = params
    var contentType: String? = nil
    
    switch method {
    case "GET", "DELETE", "HEAD":
        if values.count > 0 {
            var toString: [String] = []
            values.forEach {
                if let v = $1 as? String {
                    toString.append("\($0)=\(v)")
                }
            }
            urn = "?" + toString.joined(separator: "&")
        }
    case "JSON":
        contentType = "application/json"
        if let json = params.jsonString() {
            body.appendString(json)
        }
    default:
        timeout = 30
        if values.count > 0 {
            var i = 0
            let boundary = "iOS-\(UUID().uuidString)"
            contentType = "multipart/form-data; boundary=\(boundary)"
            for (key, value) in values {
                if let value = value {
                    body.appendString("--\(boundary)\r\nContent-Disposition: form-data; name=\"")
                    if let _ = value as? UIImage {
                        body.appendString("pictures[]\"; filename=\"\(UUID().uuidString.replaceMatches(pattern: "-", withString: "").prefix(12).lowercased()).jpg\"\r\nContent-Type: image/jpg\r\n\r\n")
                        body.append((value as! UIImage).jpegData(compressionQuality: 1)!)
                        i += 1
                    } else {
                        body.appendString("\(key)\"\r\n\r\n\(value)")
                    }
                    body.appendString("\r\n")
                }
            }
            body.appendString("--".appending(boundary.appending("--")))
        }
    }
    print("\n------------\nHTTPRequest:\n\(url)\(urn)")
    if let uri = URL(string: (url + urn).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!) {
        let session = URLSession.shared
        var request = URLRequest(url: uri)
        request.httpMethod = method == "JSON" ? "POST" : method
        request.setValue("\(APP.bundle)/\(APP.version) Build \(APP.build) (iOS \(APP.os)) \(APP.model)", forHTTPHeaderField: "user-agent")
        if let token = params["token"] as? String {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        if let mime = contentType {
            print("\nЗАПРОС К СЕРВЕРУ\n\(String(data: body as Data, encoding: String.Encoding.utf8) ?? "П У С Т О")")
            request.setValue(mime, forHTTPHeaderField: "Content-Type")
            request.setValue("keep-alive", forHTTPHeaderField: "Connection")
            request.httpBody = body as Data
            request.timeoutInterval = timeout
        }

        let load = session.dataTask(with: request, completionHandler: {(data,response,error) in
            let status = response?.getStatus ?? 1000
            print("\nОТВЕТ СЕРВЕРА СО СТАТУСОМ: \(status)\n\(String(data: data ?? Data(), encoding: String.Encoding.utf8) ?? "ПУСТОЕ")\n")
            
            DispatchQueue.main.async{() -> Void in
                completion(data, status)
            }
        })
        load.resume()
    }
    
}
