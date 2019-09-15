//
//  NetworkManager.swift
//  CoachOutletApp
//
//  Created by SR on 8/19/19.
//  Copyright © 2019 Litmus7. All rights reserved.
//

import Foundation


public struct NetworkManager {
    
    // Declarations
    public static let shared = NetworkManager()
    private let router = Router()
    
    // Log Network Activities
    public static var logActivity = true

    
    
    // MARK: Life Cycle
    private init() {
        
    }
}





extension NetworkManager {
    
    
    
    func cancelPreviousRequest() {
        
        router.cancel()
    }
    
    
    
    public func request<BodyModal: Encodable, ResponseModal: Decodable>(responseAs outputType: ResponseModal.Type = ResponseModal.self,
        endPoint: AnyEndPoint<BodyModal>,
        timeoutInterval: TimeInterval? = nil,
        onCompletion: @escaping NetworkResponse<ResponseModal>) {
        
        // Network Validaiton
        if !Reachability.isConnected() {
            
            onCompletion(.failure(NetworkError.noInternetConnection), nil, nil)
            return
        }
        
        // Send Request
        router.request(endPoint, timeoutInterval: timeoutInterval) { (data, response, error) in
            
            self.handleResponse(data, urlResponse: response, error: error, onCompletion: { (status, rawData, urlResponse) in
                
                onCompletion(status, rawData, urlResponse)
            })
        }
    }
}







extension NetworkManager {
    
    private func validateResponse<ResponseType: Decodable>(as type: ResponseType.Type, response: HTTPURLResponse) -> Result<NetworkError, ResponseType> {
        
        let statusCode = response.statusCode
        switch statusCode {
            
        case 200...299  : return .success(nil)
        case 401...500  : return .failure(.authenticatonError)
        case 501...599  : return .failure(.badrequest)
        case 600        : return .failure(.outDatedRequest)
        default         : return .failure(.requestFailure)
        }
    }
    
    
    
    private func handleResponse<ResponseType: Decodable>(_ rawData: Data?, urlResponse: URLResponse?, error: Error?, onCompletion: @escaping NetworkResponse<ResponseType>) {
        
        // Validations
        if let _error = error {
            
            onCompletion(.failure(NetworkError.error(_error)), rawData, urlResponse)
            return
        }
        
        guard let _response = urlResponse as? HTTPURLResponse else {
         
            onCompletion(.failure(.error(NetworkError.urlResponseNotSolved)), rawData, urlResponse)
            return
        }
        
            
        let result = self.validateResponse(as: ResponseType.self, response: _response)
        switch result {
            
        case .success:
            
            // Data Validaiton
            guard let responseAsData = rawData else {
                
                onCompletion(.failure(NetworkError.emptyResponse), nil, urlResponse)
                return
            }
            
            // Parsing
            do {
                
                let responseObject: ResponseType? = try Parser.parse(responseAsData)
                onCompletion(.success(responseObject), responseAsData, urlResponse)
            } catch let error as NetworkError {
                
                onCompletion(.failure(error), responseAsData, urlResponse)
            } catch {
                
                onCompletion(.failure(.error(error)), responseAsData, urlResponse)
            }
            
        case .failure(let error):
            onCompletion(.failure(error), rawData, urlResponse)
        }
    }
}


