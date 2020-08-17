//
//  BaseNetworkService.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/17/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import Foundation
import Alamofire

typealias NetworkSuccessHandler = ([String : Any]?) -> ()
typealias NetworkErrorHandler = (Error) -> ()

//MARK: - All project requests string components
struct Requests {
    static let weather = "weather"
}


class BaseNetworkService {
    //MARK: - Constants
    static let baseUrl = "https://api.openweathermap.org/data/2.5"
    static let appIdParameter = "302b5b3153622f3d6f42aa61de61076a"
    static let configuration: URLSessionConfiguration = {
        let configutation = URLSessionConfiguration.default
        configutation.timeoutIntervalForRequest = 3000
        configutation.timeoutIntervalForResource = 3000
        
        return configutation
    }()

    static let alamofireManager = AlamofireManager(configuration: BaseNetworkService.configuration)

    fileprivate static func handleResponseData(_ response: [String: Any]?, errorHandler: NetworkErrorHandler, successHandler: NetworkSuccessHandler) {
        guard let errorDict = response?["error"] as? [String : Any], let error = AlamofireError(errorDict: errorDict) else {
            successHandler(response)
            return
        }
        
        errorHandler(error)
    }

    //MARK: - Open methods
    class func parseResponse(_ response: DataResponse<Any>,
                             successHandler: @escaping NetworkSuccessHandler,
                             errorHandler: @escaping NetworkErrorHandler) {
        
        let result = response.result
        if result.isSuccess {
            if let data = result.value as? [String: AnyObject] {
                BaseNetworkService.handleResponseData(data, errorHandler: errorHandler, successHandler: successHandler)
            } else if let data = result.value as? [[String: AnyObject]] {
                BaseNetworkService.handleResponseData(["data" : data], errorHandler: errorHandler, successHandler: successHandler)
            } else {
                BaseNetworkService.handleResponseData(nil, errorHandler: errorHandler, successHandler: successHandler)
            }
        } else {
            AlamofireError.handleErrorWith(response.data, error: response.error, errorHandler: errorHandler)
        }
    }
    
    class func sendRequest(_ method: HTTPMethod,
                           request: String,
                           parameters: [String : Any]?,
                           successHandler: @escaping NetworkSuccessHandler,
                           errorHandler: @escaping NetworkErrorHandler) {
        
        
        let alamofireManager = BaseNetworkService.alamofireManager
        let url = "\(BaseNetworkService.baseUrl)/\(request)"

        alamofireManager.request(url, method: method, parameters: parameters).validate(statusCode: 200..<300).responseJSON { (response) in
            parseResponse(response, successHandler: successHandler, errorHandler: errorHandler)
        }
    }

    
}
