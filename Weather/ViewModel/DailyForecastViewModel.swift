//
//  DailyForecastViewModel.swift
//  Weather
//
//  Created by Fatih Şen on 15.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DailyForecastViewModel: ViewModel {
  typealias Model = DailyForecastModel
  
  private let byEvents: (Event) -> Intent = { event in
    return NothingIntent()
  }
  
  private let byIntents: (Intent) -> Reducer<Model> = { intent in
    return { model in
      return model
    }
  }
  
  weak var view: DailyForecastController?

	lazy var dataSet = {
		ObservableList<DailyForecast>()
	}()
	
	lazy var dataSource = {
		DailyForecastDataSource(dataSet: dataSet)
	}()
	
  private let disposeBag = DisposeBag()
  private let intents = PublishRelay<Intent>()
  private lazy var storage = { intents.asObservable()
    .toReducer(byIntents)
    .observeOn(MainScheduler.instance)
    .scan(DailyForecastModel.initState, accumulator: { o, reducer in reducer(o) })
    .replay(1)
  }()
  
  func attach() {
    disposeBag += storage.connect()
    
    if let view = view {
      disposeBag += view.viewEvents()
        .toIntent(byEvents)
        .subscribe(onNext: accept)
    }
  }
  
  func state() -> Observable<SyncState> {
    return storage.map { model in
      return model.syncState
    }
  }
  
  func store() -> Observable<DailyForecastModel> {
    return storage.asObservable()
  }
  
  func accept(intent: Intent) {
    intents.accept(intent)
  }
}
