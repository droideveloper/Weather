//
//  TodayForecastRepositoryImp.swift
//  Weather
//
//  Created by Fatih Şen on 13.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import RxSwift
import MVICocoa

class TodayForecastRepositoryImp: TodayForecastRepository {
	
	private let keyTodayForecastFile = "today_forecast.json"
	
	private let fileRepository: FileRepository
	private let weatherService: WeatherService
	
	init(fileRepository: FileRepository, weatherService: WeatherService) {
		self.fileRepository = fileRepository
		self.weatherService = weatherService
	}
	
	func loadTodayForecast() -> Observable<TodayForecast> {
		return weatherService.loadTodayForecast()
      .flatMap(persistIfNeeded(_ :))
      .catchError(ifNetworkFails(_ :))
	}
	
	fileprivate func ifNetworkFails(_ error: Error) -> Observable<TodayForecast> {
		let url = fileRepository.file(for: keyTodayForecastFile)
		return Observable.of(fileRepository)
			.flatMap { fileRepository -> Observable<TodayForecast> in
				if let url = url {
					return fileRepository.read(url: url, as: TodayForecast.self)
				}
				return Observable.error(error)
			}
	}
	
	fileprivate func persistIfNeeded(_ todayForecast: TodayForecast) -> Observable<TodayForecast> {
		let url = fileRepository.file(for: keyTodayForecastFile)
		return Observable.of(fileRepository)
			.flatMap { fileRepository -> Observable<TodayForecast> in
				if let url = url {
					return fileRepository.write(url: url, object: todayForecast)
						.andThen(Observable.of(todayForecast))
				}
				return Observable.of(todayForecast)
			}
	}
}
