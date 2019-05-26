//
//  WeatherServiceImp.swift
//  Weather
//
//  Created by Fatih Şen on 10.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import MVICocoa

class WeatherServiceImp: WeatherService {
		
	private let userDefaultsRepository: UserDefaultsRepository
	
	init(userDefaultsRepository: UserDefaultsRepository) {
		self.userDefaultsRepository = userDefaultsRepository
	}
	
	func loadTodayForecast() -> Observable<TodayForecast> {
		let request = WeatherRequestable.todayForecast(cityId: userDefaultsRepository.selectedCityId).request
		return Alamofire.request(request)
			.serialize()
	}
	
	func loadDailyForecast() -> Observable<[DailyForecast]> {
		let request = WeatherRequestable.dailyForecast(cityId: userDefaultsRepository.selectedCityId).request
		let source: Observable<DailyWeather> =  Alamofire.request(request)
			.serialize()
		return source.map { response in response.data }
	}
}
