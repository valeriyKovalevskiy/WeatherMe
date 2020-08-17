//
//  BaseDataProvider.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/17/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import Foundation

protocol DataProviderDelegate: class {
    func loadStarted(dataProvider: BaseDataProvider)
    func loadFinished(dataProvider: BaseDataProvider, with error: AlamofireError)
    func loadFinished(dataProvider: BaseDataProvider, with result: Any)
}

class BaseDataProvider {
    
    internal var isCancelled = false
    
    weak var delegate: DataProviderDelegate?
    var identifier = ""
    
    func cancel() {
        isCancelled = true
    }
    
}
