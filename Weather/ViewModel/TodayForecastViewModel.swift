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
	
	private let disposeBag = DisposeBag()
	private let intents = PublishRelay<Intent>()
	// lets make it lazy
	private lazy var storage = { intents.asObservable()
		.toReducer(convert)
		.observeOn(MainScheduler.instance)
		.scan(TodayForecastModel.initState, accumulator: { o, reducer in reducer(o) })
		.replay(1)
	}()
	
	func attach() {
		disposeBag += storage.connect()
		
		if let view = view {
			disposeBag += view.viewEvents()
				.toIntent { event in // TODO change these
					return NothingIntent()
				}
				.subscribe(onNext: { [weak weakSelf = self] intent in
					weakSelf?.accept(intent: intent)
				})
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
	
	func convert(intent: Intent) -> Reducer<TodayForecastModel> {
		return { model in return model } // TODO change this
	}
}
