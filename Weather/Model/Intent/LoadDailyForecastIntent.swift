//
//  LoadDailyForecastIntent.swift
//  Weather
//
//  Created by Fatih Şen on 15.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift
import MVICocoa

class LoadDailyForecastIntent: ObservableIntent<DailyForecastModel> {
  
  private let dailyForecastRepository: DailyForecastRepository
  
  init(dailyForecastRepository: DailyForecastRepository) {
    self.dailyForecastRepository = dailyForecastRepository
  }
  
  override func invoke() -> Observable<Reducer<DailyForecastModel>> {
    return dailyForecastRepository.loadDailyForecast()
      .delay(0.5, scheduler: MainScheduler.asyncInstance)
      .subscribeOn(MainScheduler.asyncInstance)
      .map(bySuccess(_ :))
      .catchError(byFailure(_ :))
      .startWith(byIntial())
  }
  
  private func byIntial() -> Reducer<DailyForecastModel> {
    return { model in model.copy(state: refresh) }
  }
  
  private func bySuccess(_ dailyForecasts: [DailyForecast]) -> Reducer<DailyForecastModel> {
    return { model in model.copy(state: idle, data: dailyForecasts) }
  }
  
  private func byFailure(_ error: Error) -> Observable<Reducer<DailyForecastModel>> {
    return Observable.of(
      { model in model.copy(state: Failure(error)) },
      { model in model.copy(state: idle) })
  }
}
