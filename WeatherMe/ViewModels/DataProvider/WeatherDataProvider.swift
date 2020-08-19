//
//  DataProvider.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/17/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import Foundation

class WeatherDataProvider: BaseDataProvider {
    
    //MARK: - Open methods
    func loadCurrentWeatherData<T: Codable>(for city: String, completion: @escaping (T) -> Void) {
        ServerCommunication.getCurrentWeatherData(for: city) { [weak self] (response, error) in
            guard let error = error else { return ParsingManager.shared.parse(from: response, completion: completion) }
            
            print(error.localizedDescription)
            self?.progress.dismissWithError("City doesn't exist. Try another one")
        }
    }
}
    
