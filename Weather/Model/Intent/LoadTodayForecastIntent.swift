//
//  LoadTodayForecastIntent.swift
//  Weather
//
//  Created by Fatih Şen on 13.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import RxSwift
import MVICocoa

class LoadTodayForecastIntent: ObservableIntent<TodayForecastModel> {
	
	private let todayForecastRepository: TodayForecastRepository
	
	init(todayForecastRepository: TodayForecastRepository) {
		self.todayForecastRepository = todayForecastRepository
	}
  
	override func invoke() -> Observable<Reducer<TodayForecastModel>> {
		return todayForecastRepository.loadTodayForecast()
      .delay(0.5, scheduler: MainScheduler.asyncInstance)
			.subscribeOn(MainScheduler.asyncInstance)
      .map(bySuccess (_ :))
      .catchError(byFailure(_ :))
			.startWith(byIntial())
	}
  
  private func byIntial() -> Reducer<TodayForecastModel> {
    return { model in model.copy(state: refresh) }
  }
  
  private func bySuccess(_ todayForecast: TodayForecast) -> Reducer<TodayForecastModel> {
    return { model in model.copy(state: idle, data: todayForecast) }
  }
  
  private func byFailure(_ error: Error) -> Observable<Reducer<TodayForecastModel>> {
    return Observable.of(
      { model in model.copy(state: Failure(error)) },
      { model in model.copy(state: idle) })
  }
}
