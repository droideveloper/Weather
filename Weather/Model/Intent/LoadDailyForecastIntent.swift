//
//  LoadDailyForecastIntent.swift
//  Weather
//
//  Created by Fatih Şen on 15.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift

public struct LoadDailyForecastIntent: ObservableInent {
  public typealias Model = DailyForecastModel
  
  private let dailyForecastRepository: DailyForecastRepository
  
  init(dailyForecastRepository: DailyForecastRepository) {
    self.dailyForecastRepository = dailyForecastRepository
  }
  
  private let byDefault: () -> Reducer<Model> = {
    return { model in
      return model.copy(syncState: IdleState())
    }
  }
  
  private let bySuccess: ([DailyForecast]) -> Reducer<Model> = { data in
    return { model in
      return model.copy(syncState: IdleState(), data: data)
    }
  }
  
  private let byFailure: (Error) -> Observable<Reducer<Model>> = { error in
    return Observable.create { emitter in
      // error state first
      emitter.onNext({ model in
        return model.copy(syncState: ErrorState(error: error))
      })
      
      emitter.onNext({ model in
        return model.copy(syncState: IdleState())
      })
      
      return Disposables.create()
    }
  }
  
  public func invoke() -> Observable<Reducer<Model>> {
    return dailyForecastRepository.loadDailyForecast()
      .subscribeOn(MainScheduler.asyncInstance)
      .map(bySuccess)
      .catchError(byFailure)
      .startWith(byDefault())
  }
}
