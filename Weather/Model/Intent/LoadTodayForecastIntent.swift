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
		return Observable.create { emitter in
			
			emitter.onNext({ model in
				return TodayForecastModel(syncState: ProcessState(.refresh), data: model.data)
			})
			
			
			
			return Disposables.create()
		}
	}
}
