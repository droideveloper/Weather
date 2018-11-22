//
//  DailyWeather.swift
//  Weather
//
//  Created by Fatih Şen on 9.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation

struct DailyWeather: Codable {
	var data: [DailyForecast]
	
	enum CodingKeys: String, CodingKey {
		case data = "list"
	}
}
