//
//  HTTPMethod.swift
//  CoachOutletApp
//
//  Created by SR on 8/19/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation



public enum HTTPMethod: String {
    
    case get    =   "GET"
    case post   =   "POST"
    case put    =   "PUT"
    case patch  =   "PATCH"
    case delete =   "DELETE"
    
    var name: String {
        return self.rawValue
    }
}
