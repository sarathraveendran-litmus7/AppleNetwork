//
//  NetworkError.swift
//  CoachOutletApp
//
//  Created by SR on 8/19/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    
    // Generic Type
    case error(Error)
    case noInternetConnection
    
    // Request Related
    case urlNotFound
    case badrequest
    case outDatedRequest
    case requestFailure
    case authenticatonError
    case parametersNil
    case encodingFailed
    case urlResponseNotSolved
    case emptyResponse
    case parsingFailed
    
    
    
    // Error description
    public var description: String {
        
        switch self {
        
        case .urlNotFound : return "Invalid or corrupted URL!"
        case .badrequest : return "Bad Request"
        case .outDatedRequest : return "URL request is out dated"
        case .requestFailure : return "Network request failed"
        case .authenticatonError : return "Authentication required"
        case .parametersNil : return "Parameters are nil!"
        case .encodingFailed : return "Parameter encoding failed!"
        case .urlResponseNotSolved: return "UnKnown HTTP URL response"
        case .emptyResponse : return "Response data is empty"
        case .parsingFailed: return "Response parsing failed, incompatible data!"
            
        case .noInternetConnection: return "No internet connection"
        case .error(let error) : return error.localizedDescription
        }
    }
}
