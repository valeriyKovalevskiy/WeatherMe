//
//  UIView+Ext.swift
//  WeatherMe
//
//  Created by Valeriy Kovalevskiy on 8/17/20.
//  Copyright © 2020 Valeriy Kovalevskiy. All rights reserved.
//

import UIKit

extension UIView {
    public var width: CGFloat {
        return frame.size.width
    }
    
    public var height: CGFloat {
        return frame.size.height
    }
    
    public var top: CGFloat {
        return frame.origin.y
    }
    
    public var bottom: CGFloat {
        return frame.size.height + frame.origin.y
    }
    
    public var left: CGFloat {
        return frame.origin.x
    }
    
    public var right: CGFloat {
        return frame.size.width + frame.origin.x
    }
}
