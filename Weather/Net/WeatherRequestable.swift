//
//  WeatherEndpoint.swift
//  Weather
//
//  Created by VNGRS on 9.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import Alamofire
import MVICocoa

enum WeatherRequestable: Requestable {
	case dailyForecast(cityId: Int)
	case todayForecast(cityId: Int)
	
	
	var baseUrl: String {
		get {
			return "http://api.openweathermap.org/data/\(API_VERSION)"
		}
	}
	
	var request: (HTTPMethod, URLConvertible) {
		get {
			switch self {
			case .dailyForecast(let cityId):
				return (.get, "\(baseUrl)/forecast/daily?id=\(cityId)&appid=\(API_ID)")
			case .todayForecast(let cityId):
				return (.get, "\(baseUrl)/weather?id=\(cityId)&appid=\(API_ID)")
				
			}
		}
	}
}

private let API_VERSION = "2.5"
private let API_ID = "61fa90fe66c16f3551b2c537c4d1f948"
