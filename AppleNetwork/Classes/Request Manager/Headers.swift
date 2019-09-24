//
//  ServerEndPointsHelper.swift
//  CoachOutletApp
//
//  Created by SR on 8/19/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation


public struct Header {
    
    public enum Key: String {
        
        case contentType = "Content-Type"
        case accept = "Accept"
        case authorization = "Authorization"
        
        public var name: String {
            return self.rawValue
        }
    }
    
    public enum Value: String {
        
        case json = "application/json"
        case formURLEncode = "application/x-www-form-urlencoded; charset=utf-8"
        
        public var value: String {
            return self.rawValue
        }
    }
}


