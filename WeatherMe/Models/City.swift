//
//  City.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/17/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import Foundation

//TODO: - Learn more about coding keys?

//MARK: - Current weather codable model
struct City: Codable {
    var name: String
    var id: Int
    var coord: Coord
    var main: Main
    var wind: Wind
    var weather: [Weather]
    var clouds: Clouds
    var sys: Sys
}

struct Coord: Codable {
    var lat: Double
    var lon: Double
}

struct Main: Codable {
    var temp: Double
    var temp_max: Double
    var temp_min: Double
    var feels_like: Double
    var humidity: Double
    var pressure: Double
}

struct Wind: Codable {
    var deg: Double
    var speed: Double
}

struct Weather: Codable {
    var description: String
    var id: Int
}

struct Clouds: Codable {
    var all: Int
}

struct Sys: Codable {
    var country: String
    var sunset: Double
    var sunrise: Double
    
}
