//
//  WeatherServiceImp.swift
//  Weather
//
//  Created by VNGRS on 10.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import MVICocoa

class WeatherServiceImp: WeatherService {
	
	private let headers: [String: String] = ["Content-Type": "application/json;charset=utf-8"]
	
	private let userDefaultsRepository: UserDefaultsRepository
	
	init(userDefaultsRepository: UserDefaultsRepository) {
		self.userDefaultsRepository = userDefaultsRepository
	}
	
	func loadTodayForecast() -> Observable<TodayForecast> {
		let endpoint = WeatherRequestable.todayForecast(cityId: userDefaultsRepository.selectedCityId)
		let (httpMethod, url) = endpoint.request
		return Alamofire.request(url, method: httpMethod)
			.serialize()
	}
	
	func loadDailyForecast() -> Observable<[DailyForecast]> {
		let endpoint = WeatherRequestable.dailyForecast(cityId: userDefaultsRepository.selectedCityId)
		let (httpMethod, url) = endpoint.request
		let request: Observable<DailyWeather> =  Alamofire.request(url, method: httpMethod)
			.serialize()
		return request.map { response in response.data }
	}
}
