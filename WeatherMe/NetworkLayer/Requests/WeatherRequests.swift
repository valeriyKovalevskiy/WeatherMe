//
//  WeatherRequests.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/17/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import UIKit

class WeatherRequests: BaseNetworkService {
    
    static func currentWeatherData(for city: String,
                                   successHandler: @escaping NetworkSuccessHandler,
                                   errorHandler: @escaping NetworkErrorHandler) {
        
        var parameters: [String : Any] = ["q" : city]
        parameters["appid"] = BaseNetworkService.appIdParameter
        
        sendRequest(.get,
                    request: Requests.weather,
                    parameters: parameters,
                    successHandler: successHandler,
                    errorHandler: errorHandler)
    }
}
