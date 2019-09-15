//
//  HTTPTask.swift
//  CoachOutletApp
//
//  Created by SR on 8/19/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation


public enum HTTPTask<RequestBody: Encodable> {
    
    case request
    
    case requestQueryParameters(encoding: NetworkParameterEncoding,
        urlParameters: Parameters)
    
    case requestQueryAndBodyParameters(encoding: NetworkParameterEncoding,
        urlParameters: Parameters,
        bodyParameters: RequestBody)
    
    case requestParametersAndHeader(encoding: NetworkParameterEncoding,
        urlParameters: Parameters,
        bodyParameters: RequestBody,
        additionalHeaders: HTTPHeaders)
}

