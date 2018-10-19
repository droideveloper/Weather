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
    return { model in model.copy(syncState: refresh) }
  }
  
  private let bySuccess: ([DailyForecast]) -> Reducer<Model> = { data in
    return { model in model.copy(syncState: idle, data: data) }
  }
  
  private let byFailure: (Error) -> Observable<Reducer<Model>> = { error in
    return Observable.of(
      { model in model.copy(syncState: ErrorState(error: error)) },
      { model in model.copy(syncState: idle) })
  }
  
  public func invoke() -> Observable<Reducer<Model>> {
    return dailyForecastRepository.loadDailyForecast()
      .delay(0.5, scheduler: MainScheduler.asyncInstance)
      .subscribeOn(MainScheduler.asyncInstance)
      .map(bySuccess)
      .catchError(byFailure)
      .startWith(byDefault())
  }
}
