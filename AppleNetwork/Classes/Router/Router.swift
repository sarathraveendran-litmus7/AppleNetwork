//
//  NetworkRouter.swift
//  CoachOutletApp
//
//  Created by SR on 8/19/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation


class Router: NSObject, NetworkRouter {
    
    // Declarations
    private var dataTask: URLSessionTask?
    
    lazy var downloadQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.qualityOfService = QualityOfService.background
        return queue
    }()
    lazy var downloadsSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: self, delegateQueue: downloadQueue)
    }()
    
    
    
    // MARK: Methods
    func request<RequestBody: Encodable>(_ endPoint: AnyEndPoint<RequestBody>,
                                         timeoutInterval: TimeInterval?,
                                         onCompletion: @escaping NetworkRouterOnCompletion) {
        
        let session = URLSession(configuration: .default)
        do {
            
            let request  = try self.buildRequest(from: endPoint, timeoutInterval: timeoutInterval)
            dataTask = session.dataTask(with: request, completionHandler: { [weak self] (data, urlResponse, error) in
                
                defer {
                    
                    if NetworkManager.logActivity {
                        
                        print("URL: ", request.description)
                        print("\nHeaders: ", (request.allHTTPHeaderFields ?? [:]) as Any)
                        if let body = request.httpBody {
                            
                            let rawString = String(data: body, encoding: .utf8) ?? ""
                            print("\nBody:", rawString)
                        }
                        
                        if let rawData = data {
                            
                            let rawString = String(data: rawData, encoding: .utf8) ?? "No data found"
                            print("\nURL Response", urlResponse ?? "")
                            print("\nResponse :", rawString)
                            print("\n")
                        }
                    }
                    self?.dataTask = nil
                }
                onCompletion(data, urlResponse, error)
            })
            dataTask?.resume()
        } catch let error {
            
            onCompletion(nil, nil, error)
        }
    }
    
    
    
    
    func cancel() {
        
        self.dataTask?.cancel()
    }
}




extension Router {
    
    
    
    private func buildRequest<RequestBody: Encodable>(from endPoint: AnyEndPoint<RequestBody>, timeoutInterval: TimeInterval?) throws -> URLRequest {
        
        // Preapre Sever URL
        var url = endPoint.baseURL.appendingPathComponent(endPoint.version)
        url = url.appendingPathComponent(endPoint.path)
        
        // Preapre Request
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 15)
        request.httpMethod = endPoint.httpMethod.name
        request.timeoutInterval = timeoutInterval ?? endPoint.defaultTimeoutInterval
        addHeaders(endPoint.headers, request: &request)
        
        // Preapre Headers & Input Prams (Query URL and/or Body Params)
        do {
            
            switch endPoint.task {
                
            case .request:
                break
                
            case .requestQueryParameters(let encoding, let urlParameters):
                try self.configureParameters(encoding: encoding,
                                             urlParameters: urlParameters,
                                             bodyParameters: Data(),
                                             request: &request)
                
            case .requestQueryAndBodyParameters(let encoding, let urlParameters, let bodyParameters):
                try self.configureParameters(encoding: encoding,
                                             urlParameters: urlParameters,
                                             bodyParameters: bodyParameters,
                                             request: &request)
                
            case .requestParametersAndHeader(let encoding, let urlParameters, let bodyParameters, let additionalHeaders):
                self.addHeaders(additionalHeaders, request: &request)
                try self.configureParameters(encoding: encoding,
                                             urlParameters: urlParameters,
                                             bodyParameters: bodyParameters,
                                             request: &request)
            }
            return request
        } catch {
            
            throw error
        }
    }
    
    
    
    
    func configureParameters<RequestBody: Encodable>(encoding: NetworkParameterEncoding, urlParameters: Parameters?, bodyParameters: RequestBody?, request: inout URLRequest) throws {
        
        do {
            
            try encoding.encode(urlRequest: &request, bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            
            throw error
        }
    }
    
    
    
    func addHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        
        // Validation
        guard let headers = additionalHeaders else {
            return
        }
        
        // Add Headers
        headers.forEach({ (key, value) in
            
            request.setValue(value, forHTTPHeaderField: key)
        })
    }
}



/*
 // MARK: Session Delegates
 extension Router: URLSessionDelegate {
 
 func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
 
 
 }
 
 func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
 
 
 }
 
 func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
 
 
 }
 }
 
 
 // MARK: Session Task Delegates
 extension Router: URLSessionTaskDelegate {
 
 func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
 
 
 }
 
 func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
 
 
 }
 }
 */


extension Router: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
       
        print("Finished downloading to \(location).")
    }
}
