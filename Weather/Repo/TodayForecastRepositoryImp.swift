//
//  TodayForecastRepositoryImp.swift
//  Weather
//
//  Created by Fatih Şen on 13.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift

class TodayForecastRepositoryImp: TodayForecastRepository {
	
	private let fileRepository: FileRepository
	private let weatherService: WeatherService
	
	init(fileRepository: FileRepository, weatherService: WeatherService) {
		self.fileRepository = fileRepository
		self.weatherService = weatherService
	}
	
	func loadTodayForecast() -> Observable<TodayForecast> {
		return weatherService.loadTodayForecast()
			.flatMap { [weak weakSelf = self] todayForecast -> Observable<TodayForecast> in
				if let fileRepository = weakSelf?.fileRepository {
					if let url = fileRepository.todayForecastUrl {
						return fileRepository.write(url: url, object: todayForecast)
							.andThen(Observable.just(todayForecast))
						
					}
				}
				return Observable.just(todayForecast)
			}
			.catchError { [weak weakSelf = self] error -> Observable<TodayForecast> in
				if let fileRepository = weakSelf?.fileRepository {
					if let url = fileRepository.todayForecastUrl {
						return fileRepository.read(url: url, as: TodayForecast.self)
					}
				}
				return Observable.empty()
			}
	}
}
