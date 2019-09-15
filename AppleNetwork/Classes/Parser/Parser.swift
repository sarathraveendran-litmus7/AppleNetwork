//
//  Parser.swift
//  CoachOutletApp
//
//  Created by SR on 8/19/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation

public struct Parser {
    
    static func parse<ResponseType: Decodable>(_ data: Data?) throws -> ResponseType? {
        
        // Validation
        guard let _data = data else {
            
            throw NetworkError.emptyResponse
        }
        
        // Parsing
        do {
            
            let modal = try JSONDecoder().decode(ResponseType.self, from: _data)
            return modal
        } catch {
            
            throw NetworkError.parsingFailed
        }
    }
}
