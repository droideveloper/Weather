//
//  DailyForecast.swift
//  Weather
//
//  Created by VNGRS on 9.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

struct DailyForecast: Codable, Equatable {
	
	static let empty = DailyForecast(timestamp: Int64.min, main: Main.empty, weathers: [Weather](), cloud: Cloud.empty, wind: Wind.empty)
	
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
	
	static func == (lhs: DailyForecast, rhs: DailyForecast) -> Bool {
		return lhs.timestamp == rhs.timestamp
	}
}
