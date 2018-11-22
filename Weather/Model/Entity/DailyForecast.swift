//
//  DailyForecast.swift
//  Weather
//
//  Created by Fatih Şen on 9.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation

public struct DailyForecast: Codable, Equatable {
	
  static let empty = DailyForecast(timestamp: Int64.min, tempereture: Tempereture.empty, weathers: [Weather](), cloud: Double.nan, wind: Wind.empty, speed: Double.nan, degree: Double.nan, rain: Double.nan)
	
	var timestamp: Int64
	var tempereture: Tempereture
	var weathers: [Weather]
	var cloud: Double
	var wind: Wind? = nil
  var speed: Double
  var degree: Double
  var rain: Double? = nil
	
	enum CodingKeys: String, CodingKey {
		case timestamp = "dt"
		case tempereture = "temp"
		case weathers = "weather"
		case cloud = "clouds"
		case wind
    case speed
    case degree = "deg"
    case rain
	}
	
	public static func == (lhs: DailyForecast, rhs: DailyForecast) -> Bool {
		return lhs.timestamp == rhs.timestamp
	}
}
