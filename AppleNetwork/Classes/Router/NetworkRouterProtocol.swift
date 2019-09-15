//
//  NetworkRouterProtocol.swift
//  CoachOutletApp
//
//  Created by SR on 8/19/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation


typealias NetworkRouterOnCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()


protocol NetworkRouter: class {
    
    func request<RequestBody: Encodable>(_ route: AnyEndPoint<RequestBody>, timeoutInterval: TimeInterval?, onCompletion: @escaping NetworkRouterOnCompletion)
    func cancel()
}


