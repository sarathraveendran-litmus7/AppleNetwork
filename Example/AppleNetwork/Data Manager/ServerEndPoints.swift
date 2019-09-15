//
//  ServerEndPoints.swift
//  
//
//  Created by SR on 8/19/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation
import AppleNetwork

enum ServerEndpoint: String {
    
    case baseURL = "https://reqres.in"
    case version = "/api"
    case employees = "/users"
    
    
    var asURL: URL {
        
        return URL(string: self.asString)!
    }
    var asString: String {
        
        return self.rawValue
    }
    
    static var commonHeaders: HTTPHeaders {
        var header = HTTPHeaders()
        header[Header.Value.json.value] = Header.Key.contentType.name
        header[Header.Value.json.value] = Header.Key.accept.name
        return header
    }
}
