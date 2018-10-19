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
  
  public func invoke() -> Observable<Reducer<Model>> {
    return dailyForecastRepository.loadDailyForecast()
      .delay(0.5, scheduler: MainScheduler.asyncInstance)
      .subscribeOn(MainScheduler.asyncInstance)
      .map(bySuccess)
      .catchError(byFailure)
      .startWith(byIntial())
  }
  
  private func byIntial() -> Reducer<Model> {
    return { model in model.copy(syncState: refresh) }
  }
  
  private func bySuccess(_ dailyForecasts: [DailyForecast]) -> Reducer<Model> {
    return { model in model.copy(syncState: idle, data: dailyForecasts) }
  }
  
  private func byFailure(_ error: Error) -> Observable<Reducer<Model>> {
    return Observable.of(
      { model in model.copy(syncState: ErrorState(error: error)) },
      { model in model.copy(syncState: idle) })
  }
}
