//
//  Constants.swift
//  CoachOutletApp
//
//  Created by SR on 8/19/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation


enum Messages: String {
    
    case noInternetConnection = "No internet connection!"
    
    var message: String {
        return self.rawValue
    }
}
