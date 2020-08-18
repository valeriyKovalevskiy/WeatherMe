//
//  Weather.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/18/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let weatherMainParameters: String
    let weatherCondition: String
    
    fileprivate enum WeatherCodingKeys: String, CodingKey {
        case weatherMainParameters = "main"
        case weatherCondition = "description"
    }
    
    init(from decoder: Decoder) throws {
        let weatherContainer = try decoder.container(keyedBy: WeatherCodingKeys.self)
        weatherMainParameters = try weatherContainer.decode(String.self, forKey: .weatherMainParameters)
        weatherCondition = try weatherContainer.decode(String.self, forKey: .weatherCondition)
    }
}
