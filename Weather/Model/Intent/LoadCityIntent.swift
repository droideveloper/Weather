//
//  LoadCityIntent.swift
//  Weather
//
//  Created by Fatih Şen on 6.11.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import MVICocoa
import RxSwift

class LoadCityIntent: ObservableIntent<TodayForecastModel> {

	private let cityRepository: CityRepository
	private let userDefaultsRepository: UserDefaultsRepository
	
	init(cityRepository: CityRepository, userDefaultsRepository: UserDefaultsRepository) {
    self.cityRepository = cityRepository
		self.userDefaultsRepository = userDefaultsRepository
  }

  override func invoke() -> Observable<Reducer<TodayForecastModel>> {
		let selectedCityId = userDefaultsRepository.selectedCityId
    return cityRepository.loadCities()
			.concatMap { cities -> Observable<City> in Observable.from(cities) }
			.filter { city in Int(city.id) == selectedCityId }
      .subscribeOn(MainScheduler.asyncInstance)
      .delay(0.5, scheduler: MainScheduler.asyncInstance)
      .map(bySuccess(_ :))
      .catchError(byFailure(_ :))
      .startWith(byInitial())
  }

  private func byInitial() -> Reducer<TodayForecastModel> {
    return { model in model.copy(state: refresh) }
  }

  private func bySuccess(_ city: City) -> Reducer<TodayForecastModel> {
    return { model in model.copy(state: idle, city: city) }
  }

  private func byFailure(_ error: Error) -> Observable<Reducer<TodayForecastModel>> {
    return Observable.of(
			{ model in model.copy(state: Failure(error)) },
      { model in model.copy(state: idle) })
  }
}
