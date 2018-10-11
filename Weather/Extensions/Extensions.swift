//
//  Extensions.swift
//  Weather
//
//  Created by VNGRS on 11.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

extension Double {
    
    public func kelvinToCelsius() -> Double {
        return self - 273.15
    }
    
    public func kelvinToFahrenheit() -> Double {
        return kelvinToCelsius() * 1.8 + 32
    }
}
