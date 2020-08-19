//
//  Wind.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/18/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import Foundation

struct Wind: Codable {
    let windDegree: Float
    let windSpeed: Float
    
    fileprivate enum WindCodingKeys: String, CodingKey {
        case windDegree = "deg"
        case windSpeed = "speed"
    }
    
    init(from decoder: Decoder) throws {
        let windContainer = try decoder.container(keyedBy: WindCodingKeys.self)
        windDegree = try windContainer.decode(Float.self, forKey: .windDegree)
        windSpeed = try windContainer.decode(Float.self, forKey: .windSpeed)
    }
}
