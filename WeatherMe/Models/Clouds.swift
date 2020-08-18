//
//  Clouds.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/18/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import Foundation

struct Clouds: Codable {
    let cloudsPersentage: Int
    
    fileprivate enum CloudsCodingKeys: String, CodingKey {
        case cloudsPersentage = "all"
    }
    
    init(from decoder: Decoder) throws {
        let cloudsContainer = try decoder.container(keyedBy: CloudsCodingKeys.self)
        cloudsPersentage = try cloudsContainer.decode(Int.self, forKey: .cloudsPersentage)
    }
}
