//
//  TodayForecastViewModel.swift
//  Weather
//
//  Created by Fatih Şen on 13.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class TodayForecastViewModel: ViewModel {
	public typealias Model = TodayForecastModel
	
	weak var view: TodayForecastController?
	
	// TODO change this event to intent thing in satisfying manner
	private let byEvents: (Event) -> Intent = { event in
		return NothingIntent()
	}
	
	// TODO change this intent to reducer thing in satisfying manner
	private let byIntents: (Intent) -> Reducer<TodayForecastModel> = { intent in
		return { model in
			return model
		}
	}
	
	private let disposeBag = DisposeBag()
	private let intents = PublishRelay<Intent>()
	
	private lazy var storage = { intents.asObservable()
		.toReducer(byIntents)
		.observeOn(MainScheduler.instance)
		.scan(TodayForecastModel.initState, accumulator: { o, reducer in reducer(o) })
		.replay(1)
	}()
	
	func attach() {
		disposeBag += storage.connect()
		// if my view is binded
		if let view = view {
			// then I can observe events and convert them to intents
			disposeBag += view.viewEvents()
				.toIntent(byEvents)
				.subscribe(onNext: accept)
		}
	}
	
	func store() -> Observable<TodayForecastModel> {
		return storage.asObservable()
	}
	
	func state() -> Observable<SyncState> {
		return storage.asObservable().map { model in
			return model.syncState
		}
	}
	
	func accept(intent: Intent) {
		intents.accept(intent)
	}
}
