//
//  WeatherEndpoint.swift
//  Weather
//
//  Created by VNGRS on 9.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import Alamofire

enum WeatherRequestable: Requestable {
	case dailyForecast(cityId: Int)
	case todayForecast(cityId: Int)
	
	
	var baseUrl: String {
		get {
			return "http://api.openweather.org/data/\(API_VERSION)"
		}
	}
	
	var request: (HTTPMethod, URLConvertible) {
		get {
			switch self {
			case .dailyForecast(let cityId):
				return (.get, "\(baseUrl)/forecast?id=\(cityId)&appid=\(API_ID)")
			case .todayForecast(let cityId):
				return (.get, "\(baseUrl)/weather?id=\(cityId)&appid=\(API_ID)")
				
			}
		}
	}
}

private let API_VERSION = "2.5"
private let API_ID = "b6907d289e10d714a6e88b30761fae22" // TODO change this
