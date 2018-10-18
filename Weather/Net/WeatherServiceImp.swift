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

class WeatherServiceImp: WeatherService {
	
	private let headers: [String: String] = ["Content-Type": "application/json;charset=utf-8"]
	
	private let userDefaultsRepository: UserDefaultsRepository
	
	init(userDefaultsRepository: UserDefaultsRepository) {
		self.userDefaultsRepository = userDefaultsRepository
	}
	
	func loadTodayForecast() -> Observable<TodayForecast> {
		let endpoint = WeatherRequestable.todayForecast(cityId: userDefaultsRepository.selectedCityId)
		return Observable.create { emitter  in
			let (httpMethod, url) = endpoint.request
			let request = Alamofire.request(url, method: httpMethod)
				.serialize { (response: DataResponse<TodayForecast>) in
					if let todayForecat = response.value {
						emitter.onNext(todayForecat)
						emitter.onCompleted()
					} else {
						let error = NSError(domain: "invalid json object", code: 404, userInfo: nil)
						emitter.onError(error)
					}
			}
			
			return Disposables.create {
				request.cancel()
			}
		}
	}
	
	func loadDailyForecast() -> Observable<[DailyForecast]> {
		let endpoint = WeatherRequestable.dailyForecast(cityId: userDefaultsRepository.selectedCityId)
		return Observable.create { emitter in
			let (httpMethod, url) = endpoint.request
			let request = Alamofire.request(url, method: httpMethod)
				.serialize { (response: DataResponse<DailyWeather>) in
					if let dailyWeather = response.value {
						emitter.onNext(dailyWeather.data)
						emitter.onCompleted()
					} else {
						let error = NSError(domain: "invalid json object", code: 404, userInfo: nil)
						emitter.onError(error)
					}
			}
			
			return Disposables.create {
				request.cancel()
			}
		}
	}
}
