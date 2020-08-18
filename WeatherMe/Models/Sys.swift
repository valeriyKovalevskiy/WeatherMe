//
//  Sys.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/18/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import Foundation

struct Sys: Codable {
    let countryCode: String
    let sunsetTime: Double
    let sunriseTime: Double
    
    fileprivate enum SysCodingKeys: String, CodingKey {
        case countryCode = "country"
        case sunsetTime = "sunset"
        case sunriseTime = "sunrise"
    }
    
    init(from decoder: Decoder) throws {
        let sysContainer = try decoder.container(keyedBy: SysCodingKeys.self)
        countryCode = try sysContainer.decode(String.self, forKey: .countryCode)
        sunsetTime = try sysContainer.decode(Double.self, forKey: .sunsetTime)
        sunriseTime = try sysContainer.decode(Double.self, forKey: .sunriseTime)
    }
}
