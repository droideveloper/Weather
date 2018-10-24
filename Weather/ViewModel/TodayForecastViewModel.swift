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
	
	private lazy var storage = { intents.asObservable()
    .toReducer()
		.observeOn(MainScheduler.instance)
		.scan(TodayForecastModel.initState, accumulator: { o, reducer in
      return reducer(o)
    })
		.replay(1)
	}()
	
	func attach() {
		disposeBag += storage.connect()
		// if my view is binded
		if let view = view {
			// then I can observe events and convert them to intents
			disposeBag += view.viewEvents()
				.toIntent(byEvents(_:))
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
  
  private func byEvents(_ event: Event) throws -> Intent {
   return event.toIntent(container: view?.container)
  }
}
