//
//  NetworkHelper.swift
//  CoachOutletApp
//
//  Created by SR on 8/19/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]
public typealias Parameters = [String: Any]


public protocol EndPoint {

    associatedtype BodyParameters: Encodable

    var baseURL: URL { get }
    var version: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask<BodyParameters> { get }
    var headers: HTTPHeaders { get }
    var defaultTimeoutInterval: TimeInterval { get }
}


// Type Erasure
public struct AnyEndPoint<RequestBody: Encodable>: EndPoint {
   
    private let _baseURL: URL
    private let _version: String
    private let _path: String
    private let _httpMethod: HTTPMethod
    private let _task: HTTPTask<RequestBody>
    private let _headers: HTTPHeaders
    private let _defaultTimeoutInterval: TimeInterval
    
    public init<U: EndPoint>(_ endpoint: U) where U.BodyParameters == RequestBody {
        
        self._baseURL = endpoint.baseURL
        self._version = endpoint.version
        self._path = endpoint.path
        self._httpMethod = endpoint.httpMethod
        self._task = endpoint.task
        self._headers = endpoint.headers
        self._defaultTimeoutInterval = endpoint.defaultTimeoutInterval
    }
    
    public var baseURL: URL { return self._baseURL }
    public var version: String { return self._version }
    public var path: String { return self._path }
    public var httpMethod: HTTPMethod { return self._httpMethod }
    public var task: HTTPTask<RequestBody> { return self._task }
    public var headers: HTTPHeaders { return self._headers }
    public var defaultTimeoutInterval: TimeInterval { return self._defaultTimeoutInterval }
}

