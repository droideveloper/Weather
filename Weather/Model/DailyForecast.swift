//
//  DailyForecast.swift
//  Weather
//
//  Created by VNGRS on 9.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

struct DailyForecast: Codable {
	var timestamp: Int64
	var main: Main
	var weathers: [Weather]
	var cloud: Cloud
	var wind: Wind
	
	enum CodingKeys: String, CodingKey {
		case timestamp = "dt"
		case main
		case weathers = "weather"
		case cloud = "clouds"
		case wind
	}
}
