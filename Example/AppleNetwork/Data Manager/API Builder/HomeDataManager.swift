//
//  HomeDataManager.swift
//  
//
//  Created by SR on 8/21/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation
import AppleNetwork

class HomeDataManager {
    
    static let shared = HomeDataManager()
    var network: NetworkManager = {
        let controller = NetworkManager.shared
        NetworkManager.logActivity = false
        return controller
    }()
    
    let inputModal = InputModel()
    let output = OutPutModel()
    
    func fetchEmployeesList() {
        
        let endpoint = AnyEndPoint(HomeAPI<InputModel>.feedsWithParams(queryParams: Parameters(), bodyParams: InputModel()))
        network.request(responseAs: OutPutModel.self, endPoint: endpoint, timeoutInterval: 3) { (status, data, urlresponse) in
            print(status)
        }
    }
    
}
