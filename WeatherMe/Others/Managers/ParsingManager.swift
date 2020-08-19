//
//  ParsingManager.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/18/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import Foundation

class ParsingManager {
    static let shared = ParsingManager()
    
    func parse<T: Codable>(from response: [String: Any]?, completion: @escaping (T) -> Void) {
        do {
            guard let response = response else { return }
            guard let jsonData = try? JSONSerialization.data(withJSONObject: response) else { return }
            
            let city = try JSONDecoder().decode(T.self, from: jsonData)
            completion(city)
        }
        catch let error {
            ProgressManager.shared.dismissWithError(error)
        }
    }
    
    
}
