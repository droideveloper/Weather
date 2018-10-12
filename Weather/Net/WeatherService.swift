//
//  WeatherService.swift
//  Weather
//
//  Created by VNGRS on 9.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift

protocol WeatherService {
	
	func loadTodayForecast() -> Single<TodayForecast>
	func loadDailyForecast() -> Single<[DailyForecast]>
}
