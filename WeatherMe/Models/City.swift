//
//  City.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/17/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import Foundation

struct City: Codable {
    let coordinates: Coord
    let weather: [Weather]
    let mainParameters: Main
    let wind: Wind
    let clouds: Clouds
    let timeOfDataCalculation: Float
    let sys: Sys
    let timezone: Float
    let id: Int
    let name: String
    
    fileprivate enum CityCodingKeys: String, CodingKey {
        case coordinates = "coord"
        case weather = "weather"
        case mainParameters = "main"
        case wind = "wind"
        case clouds = "clouds"
        case timeOfDataCalculation = "dt"
        case sys = "sys"
        case timezone = "timezone"
        case id = "id"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CityCodingKeys.self)
        coordinates = try values.decode(Coord.self, forKey: .coordinates)
        weather = try values.decode([Weather].self, forKey: .weather)
        mainParameters = try values.decode(Main.self, forKey: .mainParameters)
        wind = try values.decode(Wind.self, forKey: .wind)
        clouds = try values.decode(Clouds.self, forKey: .clouds)
        timeOfDataCalculation = try values.decode(Float.self, forKey: .timeOfDataCalculation)
        sys = try values.decode(Sys.self, forKey: .sys)
        timezone = try values.decode(Float.self, forKey: .timezone)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
    }
}
