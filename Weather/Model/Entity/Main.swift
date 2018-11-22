//
//  Main.swift
//  Weather
//
//  Created by Fatih Şen on 9.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation

struct Main: Codable, Equatable {
	
	static let empty = Main(temperature: Double.nan, pressure: Double.nan, humidity: Double.nan, minTemperature: Double.nan, maxTemperature: Double.nan)
	
	var temperature: Double
	var pressure: Double
	var humidity: Double
	var minTemperature: Double
	var maxTemperature: Double
	
	enum CodingKeys: String, CodingKey {
		case temperature = "temp"
		case pressure
		case humidity
		case minTemperature = "temp_min"
		case maxTemperature = "temp_max"
	}
  
  static func == (lhs: Main, rhs: Main) -> Bool {
    return lhs.humidity == rhs.humidity
  }
}

