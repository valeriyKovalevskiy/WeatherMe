//
//  Main.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/18/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import Foundation

struct Main: Codable {
    let temperature: Float
    let maxTemperature: Float
    let minTemperature: Float
    let feelsLikeTemperature: Float
    let humidity: Float
    let pressure: Float
    
    fileprivate enum MainCodingKeys: String, CodingKey {
        case temperature = "temp"
        case maxTemperature = "temp_max"
        case minTemperature = "temp_min"
        case feelsLikeTemperature = "feels_like"
        case humidity = "humidity"
        case pressure = "pressure"
    }
    
    init(from decoder: Decoder) throws {
        let mainContainer = try decoder.container(keyedBy: MainCodingKeys.self)
        temperature = try mainContainer.decode(Float.self, forKey: .temperature)
        maxTemperature = try mainContainer.decode(Float.self, forKey: .maxTemperature)
        minTemperature = try mainContainer.decode(Float.self, forKey: .minTemperature)
        feelsLikeTemperature = try mainContainer.decode(Float.self, forKey: .feelsLikeTemperature)
        humidity = try mainContainer.decode(Float.self, forKey: .humidity)
        pressure = try mainContainer.decode(Float.self, forKey: .pressure)
    }
}
