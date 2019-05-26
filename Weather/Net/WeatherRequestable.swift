//
//  WeatherEndpoint.swift
//  Weather
//
//  Created by Fatih Şen on 9.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
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
	
	var request: URLRequest {
		get {
			switch self {
			case .dailyForecast(let cityId):
				guard let uri = URL(string: "\(baseUrl)/forecast/daily?id=\(cityId)&appid=\(API_ID)") else {
					fatalError("\(baseUrl)/forecast/daily?id=\(cityId)&appid=\(API_ID), can not validated as url")
				}
				var request = URLRequest(url: uri)
				request.httpMethod = HTTPMethod.get.rawValue
				return request
			case .todayForecast(let cityId):
				guard let uri = URL(string: "\(baseUrl)/weather?id=\(cityId)&appid=\(API_ID)") else {
					fatalError("\(baseUrl)/weather?id=\(cityId)&appid=\(API_ID), can not validated as url")
				}
				var request = URLRequest(url: uri)
				request.httpMethod = HTTPMethod.get.rawValue
				return request
			}
		}
	}
}

private let API_VERSION = "2.5"
private let API_ID = "61fa90fe66c16f3551b2c537c4d1f948"
