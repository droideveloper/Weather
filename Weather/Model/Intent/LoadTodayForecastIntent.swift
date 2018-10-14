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
	
	private let byDefaultState: () -> Reducer<Model> = {
		return { model in
			return TodayForecastModel(syncState: ProcessState(.refresh), data: model.data)
		}
	}
	
	private let bySuccess: (TodayForecast) -> Reducer<Model> = { todayForecast in
		return { model in
			return TodayForecastModel(syncState: IdleState(), data: todayForecast)
		}
	}
	
	private let byFailure: (Error) -> Observable<Reducer<Model>> = { error in
		return Observable.create { emitter in
			// singal error state first
			emitter.onNext({ model in
				return TodayForecastModel(syncState: ErrorState(error: error), data: model.data)
			})
			// after we signal error we do not go on with error state
			emitter.onNext({ model in
				return TodayForecastModel(syncState: IdleState(), data: model.data)
			})
			
			return Disposables.create()
		}
	}
	
	public func invoke() -> Observable<Reducer<Model>> {
		return todayForecastRepository.loadTodayForecast()
			.subscribeOn(MainScheduler.asyncInstance)
			.map(bySuccess)
			.catchError(byFailure)
			.startWith(byDefaultState())
	}
}
