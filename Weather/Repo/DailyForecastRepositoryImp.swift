//
//  DailyForecastRepositoryImp.swift
//  Weather
//
//  Created by Fatih Şen on 13.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift

class DailyForecastRepositoryImp: DailyForecastRepository {
	
	private let fileRepository: FileRepository
	private let weatherService: WeatherService
	
	init(fileRepository: FileRepository, weatherService: WeatherService) {
		self.fileRepository = fileRepository
		self.weatherService = weatherService
	}
	
	func loadDailyForecast() -> Observable<[DailyForecast]> {
		return weatherService.loadDailyForecast()
			.flatMap { [weak weakSelf = self] dailyForecasts -> Observable<[DailyForecast]> in
				if let fileRepository = weakSelf?.fileRepository {
					if let url = fileRepository.dailyForecastUrl {
						return fileRepository.write(url: url, object: dailyForecasts)
							.andThen(Observable.just(dailyForecasts))
					}
				}
				return Observable.just(dailyForecasts)
			}
			.catchError { [weak weakSelf = self] error -> Observable<[DailyForecast]> in
				if let fileRepository = weakSelf?.fileRepository {
					if let url = fileRepository.dailyForecastUrl {
						return fileRepository.read(url: url, as: [DailyForecast].self)
					}
				}
				return Observable.empty()
			}
	}
}
