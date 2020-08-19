//
//  Float+Ext.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/19/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import Foundation

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
