//
//  ServerCommunication.swift
//  IMMOMIG
//
//  Created by Maksym Lazebnyi on 12/12/16.
//  Copyright © 2016 Maksym Lazebnyi. All rights reserved.
//

import Foundation


class ServerCommunication {
    typealias CompletionBlock = (_ response: [String: Any]?, _ error: AlamofireError?) -> ()
    
    fileprivate static func successHandler(_ completion: @escaping CompletionBlock) -> NetworkSuccessHandler {
        let successHandler: NetworkSuccessHandler = { (response) in
            if let error = response?["error"] {
                completion(nil, error as? AlamofireError)
            } else {
                completion(response, nil)
            }
        }
        
        return successHandler
    }
    
    fileprivate static func errorHandler(_ completion: @escaping CompletionBlock) -> NetworkErrorHandler {
        let errorHandler: NetworkErrorHandler = { (error) in
            completion(nil, error as? AlamofireError)
        }
        return errorHandler
    }
    
    
    
    static func getCurrentWeatherData(for city: String, completion: @escaping CompletionBlock) {
        WeatherRequests.currentWeatherData(for: city,
                                           successHandler: ServerCommunication.successHandler(completion),
                                           errorHandler: ServerCommunication.errorHandler(completion))
    }
    
    
}

