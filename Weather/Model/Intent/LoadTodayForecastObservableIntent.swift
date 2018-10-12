//
//  LoadTodayForecastObservableIntent.swift
//  Weather
//
//  Created by Fatih Şen on 12.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoadTodayForecastObservableIntent: ObservableIntent {
	typealias Model = TodayForecastModel
	
	fileprivate let todayForecastRepository: TodayForecastRepository

	init(todayForecastRepository: TodayForecastRepository) {
		self.todayForecastRepository = todayForecastRepository
	}
	
	func invoke() -> Observable<Reducer<TodayForecastModel>> {
		return todayForecastRepository.loadTodayForecast()
			.subscribeOn(ConcurrentMainScheduler.instance)
			.map { todayForecast in
				return { model in
					return TodayForecastModel(syncState: IdleState(), data: todayForecast)
				}
			}
			.catchError { error in
				return Observable.merge(
					Observable.just({ model in
						return TodayForecastModel(syncState: ErrorState(error: error), data: TodayForecast.empty)
					}),
					Observable.just({ model in
						return TodayForecastModel(syncState: IdleState(), data: TodayForecast.empty)
					})
				)
			}
			.startWith({ model in
				return TodayForecastModel(syncState: ProcessState(type: .refresh), data: TodayForecast.empty)
			})
	}
}
