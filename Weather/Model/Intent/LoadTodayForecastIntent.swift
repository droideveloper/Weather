//
//  LoadTodayForecastIntent.swift
//  Weather
//
//  Created by Fatih Şen on 13.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift

public struct LoadTodayForecastIntent: ObservableInent {
	public typealias Model = TodayForecastModel
	
	private let todayForecastRepository: TodayForecastRepository
	
	init(todayForecastRepository: TodayForecastRepository) {
		self.todayForecastRepository = todayForecastRepository
	}
  
	public func invoke() -> Observable<Reducer<Model>> {
		return todayForecastRepository.loadTodayForecast()
      .delay(0.5, scheduler: MainScheduler.asyncInstance)
			.subscribeOn(MainScheduler.asyncInstance)
			.map(bySuccess)
			.catchError(byFailure)
			.startWith(byIntial())
	}
  
  private func byIntial() -> Reducer<Model> {
    return { model in model.copy(syncState: refresh) }
  }
  
  private func bySuccess(_ todayForecast: TodayForecast) -> Reducer<Model> {
    return { model in model.copy(syncState: idle, data: todayForecast) }
  }
  
  private func byFailure(_ error: Error) -> Observable<Reducer<Model>> {
    return Observable.of(
      { model in model.copy(syncState: ErrorState(error: error)) },
      { model in model.copy(syncState: idle) })
  }
}
