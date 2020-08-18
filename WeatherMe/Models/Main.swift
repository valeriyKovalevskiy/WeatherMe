//
//  Main.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/18/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import Foundation

struct Main: Codable {
    let temperature: Double
    let maxTemperature: Double
    let minTemperature: Double
    let feelsLikeTemperature: Double
    let humidity: Double
    let pressure: Double
    
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
        temperature = try mainContainer.decode(Double.self, forKey: .temperature)
        maxTemperature = try mainContainer.decode(Double.self, forKey: .maxTemperature)
        minTemperature = try mainContainer.decode(Double.self, forKey: .minTemperature)
        feelsLikeTemperature = try mainContainer.decode(Double.self, forKey: .feelsLikeTemperature)
        humidity = try mainContainer.decode(Double.self, forKey: .humidity)
        pressure = try mainContainer.decode(Double.self, forKey: .pressure)
    }
}
