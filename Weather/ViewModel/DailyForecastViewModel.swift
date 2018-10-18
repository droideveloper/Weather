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
  
  weak var view: DailyForecastController?
  
  private let disposeBag = DisposeBag()
  private let intents = PublishRelay<Intent>()
  private lazy var storage = { intents.asObservable()
    .toReducer(byIntents(_:))
    .observeOn(MainScheduler.instance)
    .scan(DailyForecastModel.initState, accumulator: { o, reducer in
      return reducer(o)
    })
    .replay(1)
  }()
  
  func attach() {
    disposeBag += storage.connect() // will keep my stream in-line since I want my stream continous till model dies
    
    if let view = view {
      disposeBag += view.viewEvents()
        .toIntent(byEvents(_:))
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
  
  private func byEvents(_ event: Event) -> Intent {
    if event is LoadDailyForecastEvent {
      if let container = view?.container {
        if let dailyForecastRepository = container.resolve(DailyForecastRepository.self) {
          return LoadDailyForecastIntent(dailyForecastRepository: dailyForecastRepository)
        }
      }
    }
    return NothingIntent()
  }
  
  private func byIntents(_ intent: Intent) -> Observable<Reducer<Model>> {
    if let intent = intent as? LoadDailyForecastIntent {
      return intent.invoke()
    }
    return Observable.just({ model in return model })
  }
}
