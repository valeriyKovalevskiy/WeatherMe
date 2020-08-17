//
//  AlamofireManager.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/17/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireManager: Alamofire.SessionManager {

    override open func request(_ url: URLConvertible,
                               method: HTTPMethod = .get,
                               parameters: Parameters? = nil,
                               encoding: ParameterEncoding = JSONEncoding.default,
                               headers: HTTPHeaders? = nil) -> DataRequest
    {
        var fullParameters: [String: Any]? = [:]
        if parameters != nil {
            fullParameters = parameters
        }

        var fullHeaders: [String: String]? = [:]
        if headers != nil {
            fullHeaders = headers
        }

        if method == .get {
            return super.request(url, method: method, parameters: fullParameters, encoding: URLEncoding.default, headers: fullHeaders)
        }

        return super.request(url, method: method, parameters: fullParameters, encoding: encoding, headers: fullHeaders)
    }


}
