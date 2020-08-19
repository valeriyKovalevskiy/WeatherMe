//
//  SearchViewControllerViewModel.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/17/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import Foundation
import RxSwift

class SearchViewControllerViewModel {
    
    fileprivate let provider = WeatherDataProvider()

    func fetchDocumets() -> Observable<[City]> {
        return Observable.create { observer -> Disposable in
            guard let path = Bundle.main.path(forResource: "restaurants", ofType: "json") else {
                observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                return Disposables.create {  }
            }
            
            let task = URLSession.shared.dataTask(with: URL(string: "url-here")!) { data, _,_ in
                guard let data = data else {
                    observer.onError(NSError(domain: "", code: -1, userInfo: nil))
                    return //Disposables.create {  }
                }
                
                do {
//                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let restaraunts = try JSONDecoder().decode([City].self, from: data)
                    observer.onNext(restaraunts)
                }
                catch {
                    observer.onError(error)
                }
                
            }
            task.resume()
            
            return Disposables.create { }
        }
        
    }
    //MARK: - Open methods
    func getDocuments(for city: String, completion: @escaping (City) -> Void) {
        provider.loadCurrentWeatherData(for: city) { (result) in
            completion(result)
        }
    }
    
}

    

