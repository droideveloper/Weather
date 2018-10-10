//
//  TodayForecast.swift
//  Weather
//
//  Created by VNGRS on 9.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

class TodayForecast: Codable {
    var coordinate: Coordinate
    var weathers: [Weather]
    var main: Main
    var visibility: Int
    var wind: Wind
    var cloud: Cloud
    var timestamp: Int64
    var sys: Sys
    var id: Int64
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case coordinate = "coord"
        case weathers = "weather"
        case main
        case visibility
        case wind
        case cloud = "clouds"
        case timestamp = "dt"
        case sys
        case id
        case name
    }
}
