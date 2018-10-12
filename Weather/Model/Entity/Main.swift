//
//  Main.swift
//  Weather
//
//  Created by VNGRS on 9.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

struct Main: Codable {
	
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
}

