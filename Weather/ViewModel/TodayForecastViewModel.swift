//
//  TodayForecastViewModel.swift
//  Weather
//
//  Created by Fatih Şen on 12.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TodayForecastViewModel: ViewModelable {
	
	typealias M = TodayForecastModel
	
	private let intents = PublishRelay<LoadTodayForecastObservableIntent>()
	private let disposeBag = DisposeBag()
	
	private let view: Viewable
	
	private let storage: Observable<TodayForecastModel>
	
	init(view: Viewable) {
		self.view = view
		self.storage = intents.asObservable()
			.flatMap { intent in return intent.invoke() }
			.scan(TodayForecastModel.initState, accumulator: { o, reducer in
				return reducer(o)
			})
			.replay(1)
	}
	
	func store() -> Observable<TodayForecastModel> {
		return storage.asObservable()
	}
	
	func attach() {
		
	}
	
	func detach() {

	}
	
	func accept(intent: Intent) {
		if let loadTodayForecastObservableIntent = intent as? LoadTodayForecastObservableIntent {
			intents.accept(loadTodayForecastObservableIntent)
		}
	}
}
