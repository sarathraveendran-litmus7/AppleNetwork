//
//  NetworkManager.swift
//  CoachOutletApp
//
//  Created by SR on 8/19/19.
//  Copyright © 2019 Litmus7. All rights reserved.s
//

import Foundation



public typealias NetworkResponse<ResponseType: Decodable> = (_ status: Result<NetworkError, ResponseType>, _ rawData: Data?, _ urlResponse: URLResponse?) -> ()



public enum Result<NetworkError, ResponseType> {
    
    case success(ResponseType?)
    case failure(NetworkError)
}

 
