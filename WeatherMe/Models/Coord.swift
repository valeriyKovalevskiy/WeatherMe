//
//  Coord.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/18/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import Foundation

struct Coord: Codable {
    let latitude: Double
    let longitude: Double
    
    fileprivate enum CoordinatesCodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
    
    init(from decoder: Decoder) throws {
        let coordinatesContainer = try decoder.container(keyedBy: CoordinatesCodingKeys.self)
        latitude = try coordinatesContainer.decode(Double.self, forKey: .latitude)
        longitude = try coordinatesContainer.decode(Double.self, forKey: .longitude)
    }
}
