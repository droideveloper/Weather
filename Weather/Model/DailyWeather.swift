//
//  DailyWeather.swift
//  Weather
//
//  Created by VNGRS on 9.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

struct DailyWeather: Codable {
	var data: [DailyForecast]
	
	enum CodingKeys: String, CodingKey {
		case data = "list"
	}
}
