//
//  NetworkRequestEncoder.swift
//  CoachOutletApp
//
//  Created by SR on 8/19/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation

struct URLParameterEncoder: ParameterEncoder {
    
    func encode(urlRequest: inout URLRequest, with paramters: Parameters) throws {
    
        // Validation
        guard let url = urlRequest.url else {

            throw NetworkError.urlNotFound
        }

        // Prepare URL with Query Params
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !paramters.isEmpty {

            urlComponents.queryItems = [URLQueryItem]()
            paramters.forEach { (key, value) in

                guard let valueAsString = value as? String else {
                    return
                }

                let queryItem = URLQueryItem(name: key, value: valueAsString)
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }

        // Set header type
        urlRequest.setValue(Header.Value.formURLEncode.value, forHTTPHeaderField: Header.Key.contentType.name)
    }
}






struct JSONParameterEncoder: ParameterEncoder {
   
    func encode(urlRequest: inout URLRequest, with paramters: Parameters) throws {
        
        do {
            
            // Set body As JSON data
            let jsonAsData = try JSONSerialization.data(withJSONObject: paramters, options: JSONSerialization.WritingOptions.prettyPrinted)
            urlRequest.httpBody = jsonAsData
            
            // Set Header
            urlRequest.setValue(Header.Value.json.value, forHTTPHeaderField: Header.Key.contentType.name)
        } catch {
            
            throw NetworkError.encodingFailed
        }
    }
}





struct JSONModalEncoder: JSONObjectEncoder {
    
    func encode<RequestBody: Encodable>(urlRequest: inout URLRequest, with paramters: RequestBody) throws {
        
        do {
            
            // Set body As JSON data
            let jsonAsData = try JSONEncoder().encode(paramters)
            urlRequest.httpBody = jsonAsData
            
            // Set Header
            urlRequest.setValue(Header.Value.json.value, forHTTPHeaderField: Header.Key.contentType.name)
        } catch {
            
            throw NetworkError.encodingFailed
        }
    }
}




