//
//  Dictionary.swift
//  CoachOutletApp
//
//  Created by SR on 8/28/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation

extension Dictionary {
    
    // Merge two Dictionaries
    static func +(lhs: [Key: Value], rhs: [Key: Value]) -> [Key: Value] {
        
        return lhs.merging(rhs){$1}
    }
}

