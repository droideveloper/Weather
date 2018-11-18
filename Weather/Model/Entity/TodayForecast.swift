//
//  TodayForecast.swift
//  Weather
//
//  Created by VNGRS on 9.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

public struct TodayForecast: Codable, Equatable {
	
  static let empty = TodayForecast(coordinate: Coordinate.empty, weathers: [Weather](), main: Main.empty, visibility: Int32.min, wind: Wind.empty, cloud: Cloud.empty, timestamp: Int64.min, rain: Rain.empty, sys: Sys.empty, id: Int64.min, name: String.empty)
	
	var coordinate: Coordinate
	var weathers: [Weather]
	var main: Main
	var visibility: Int32
	var wind: Wind
	var cloud: Cloud
	var timestamp: Int64
  var rain: Rain?
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
	
	public static func == (lhs: TodayForecast, rhs: TodayForecast) -> Bool {
		return lhs.id == rhs.id
	}
}
