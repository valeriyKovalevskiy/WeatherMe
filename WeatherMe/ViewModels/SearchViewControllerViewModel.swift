//
//  SearchViewControllerViewModel.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/17/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import Foundation

class SearchViewControllerViewModel {
    
    fileprivate let provider = WeatherDataProvider()
        
    func getDocuments(for city: String, completion: @escaping (City) -> Void) {
        provider.loadCurrentWeatherData(for: city) { (result) in
            
            completion(result)
            
        }
    }
    
    }


