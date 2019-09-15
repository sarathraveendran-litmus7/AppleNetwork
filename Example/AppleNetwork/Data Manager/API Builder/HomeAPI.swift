//
//  SampleBuilder.swift
//  
//
//  Created by SR on 8/19/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation
import AppleNetwork


enum HomeAPI<T: Encodable>: EndPoint {
    
    case feeds
    case feedsWithParams(queryParams: Parameters, bodyParams: T)
    
    
    var baseURL: URL {
        
        return ServerEndpoint.baseURL.asURL
    }
    
    var version: String {
        
        return ServerEndpoint.version.asString
    }
    
    var path: String {
        
        switch self {
        
        case .feeds:
        return ServerEndpoint.employees.asString
            
        case .feedsWithParams(_):
            return ServerEndpoint.employees.asString
            
        }
    }
    
    var httpMethod: HTTPMethod {
        
        switch self {
        case .feeds:
            return .get
            
        case .feedsWithParams(_):
            return .get

        }
    }
    
    var task: HTTPTask<T> {
        
        switch self {
            
        case .feeds:
            return .request
            
        case .feedsWithParams(let params, let bodyParams):
            return .requestParametersAndHeader(encoding: .jsonEncoding, urlParameters: params, bodyParameters: bodyParams, additionalHeaders: HTTPHeaders())
        }
    }
    
    var headers: HTTPHeaders {
        
        return ServerEndpoint.commonHeaders
    }
    
    var defaultTimeoutInterval: TimeInterval {
        
        return 10
    }
}


struct InputModel: Encodable {
    
    var id: String?
    var employee_name: String?
    var employee_salary: String?
    var employee_age: String?
    var profile_image: String?
}


struct OutPutModel: Decodable {
    
    var page: Int?
    var per_page: Int?
    var total: Int?
    var total_pages: Int?
    var data: [User]?
    
    struct User: Decodable {
        var id: Int?
        var email: String?
        var first_name: String?
        var last_name: String?
        var avatar: String?
    }
}
