//
//  DailyForecastRepositoryImp.swift
//  Weather
//
//  Created by Fatih Şen on 13.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import RxSwift
import MVICocoa

class DailyForecastRepositoryImp: DailyForecastRepository {
	
	private let keyDailyForecastFile = "daily_forecast.json"
	
	private let fileRepository: FileRepository
	private let weatherService: WeatherService
	
	init(fileRepository: FileRepository, weatherService: WeatherService) {
		self.fileRepository = fileRepository
		self.weatherService = weatherService
	}
	
	func loadDailyForecast() -> Observable<[DailyForecast]> {
		return weatherService.loadDailyForecast()
      .flatMap(persistIfNeeded(_ :))
      .catchError(ifNetworkFails(_ :))
	}
	
	fileprivate func ifNetworkFails(_ error: Error) -> Observable<[DailyForecast]> {
		let url = fileRepository.file(for: keyDailyForecastFile)
		return Observable.of(fileRepository)
			.flatMap { fileRepository -> Observable<[DailyForecast]> in
				if let url = url {
					return fileRepository.read(url: url, as: [DailyForecast].self)
				}
				return Observable.error(error)
			}
	}
	
	fileprivate func persistIfNeeded(_ dailyForecasts: [DailyForecast]) -> Observable<[DailyForecast]> {
		let url = fileRepository.file(for: keyDailyForecastFile)
		return Observable.of(fileRepository)
			.flatMap { fileRepository -> Observable<[DailyForecast]> in
				if let url = url {
					return fileRepository.write(url: url, object: dailyForecasts)
						.andThen(Observable.of(dailyForecasts))
				}
				return Observable.of(dailyForecasts)
			}
	}
}
