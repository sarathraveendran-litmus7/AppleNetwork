//
//  RequestEncoderProtocols.swift
//  CoachOutletApp
//
//  Created by SR on 8/20/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation

protocol ParameterEncoder {
    
    func encode(urlRequest: inout URLRequest, with paramters: Parameters) throws
}


protocol JSONObjectEncoder {
    
    func encode<DataType: Encodable>(urlRequest: inout URLRequest, with paramters: DataType) throws
}
