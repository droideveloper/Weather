//
//  WeatherService.swift
//  Weather
//
//  Created by Fatih Şen on 9.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import RxSwift

protocol WeatherService {
	
	func loadTodayForecast() -> Observable<TodayForecast>
	func loadDailyForecast() -> Observable<[DailyForecast]>
}
