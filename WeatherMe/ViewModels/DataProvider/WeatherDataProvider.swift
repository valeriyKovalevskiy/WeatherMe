//
//  DataProvider.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/17/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import Foundation

class WeatherDataProvider: BaseDataProvider {
    
    func loadCurrentWeatherData(for city: String, completion: @escaping (City) -> Void) { //throw model into closure
        ServerCommunication.getCurrentWeatherData(for: city) { [weak self] (response, error) in
            guard let strongSelf = self else { return }
            
            if let error = error {
                //handle error
//                strongSelf.delegate?.loadFinished(dataProvider: strongSelf, with: error)
            } else {
                do {
                    if let jsonData = try? JSONSerialization.data(withJSONObject: response) {
                        let city = try JSONDecoder().decode(City.self, from: jsonData)
                        print("\(city.name)")
                        print("************")
//                        print("\(city.weather.description)")
//                        print("************")
                        print("\(city.sys.sunrise); \(city.coord.lon)")
                        let timeInterval = NSDate(timeIntervalSince1970: city.sys.sunrise)
                        print("************\(timeInterval)")
//                        print("\(city.wind.speed)")

                        print(response)
                    }

                }

                catch let error {
                    print(error.localizedDescription)
                }
//                if let propertyDicts = response!["data"] as? [[String : Any]] {
//                    if let models = ParsingService<ProjectModel>().parse(propertyDicts) {
//                        //create parser
//                        completion(models)
//                    }
//                }
            }
        }
    }
    
    
}
