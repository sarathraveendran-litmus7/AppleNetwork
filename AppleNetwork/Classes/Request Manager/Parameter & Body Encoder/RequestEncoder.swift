//
//  RequestEncodingManager.swift
//  CoachOutletApp
//
//  Created by SR on 8/20/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation


public enum NetworkParameterEncoding {
    
    case urlEncoding
    case jsonEncoding
    case urlAndJsonEncoding
    
    public func encode<RequestBody: Encodable>(urlRequest: inout URLRequest, bodyParameters: RequestBody?, urlParameters: Parameters?) throws {
        
        do {
            
            switch self {
                
            case .urlEncoding:
                guard let urlParameters = urlParameters else {
                    return
                }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                
            case .jsonEncoding:
                guard let bodyParameters = bodyParameters else {
                    return
                }
                try JSONModalEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                
            case .urlAndJsonEncoding:
                guard let urlParameters = urlParameters,
                    let bodyParameters = bodyParameters  else {
                        return
                }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                try JSONModalEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
            }
        } catch {
            
            throw error
        }
    }
}



