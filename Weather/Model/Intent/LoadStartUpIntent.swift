//
//  LoadStartUpIntent.swift
//  Weather
//
//  Created by Fatih Şen on 18.11.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import MVICocoa
import RxSwift

class LoadStartUpIntent: ObservableIntent<StartUpModel> {

	private let cityRepository: CityRepository
	
	init(cityRepository: CityRepository) {
    self.cityRepository = cityRepository
  }

  override func invoke() -> Observable<Reducer<StartUpModel>> {
    return cityRepository.loadCities()
      .subscribeOn(MainScheduler.asyncInstance)
      .delay(0.5, scheduler: MainScheduler.asyncInstance)
      .map(bySuccess(_ :))
      .catchError(byFailure(_ :))
      .startWith(byInitial())
  }

  private func byInitial() -> Reducer<StartUpModel> {
		return { model in model.copy(state: refresh) }
  }

  private func bySuccess(_ data: [City]) -> Reducer<StartUpModel> {
    return { model in model.copy(state: idle, data: data) }
  }

  private func byFailure(_ error: Error) -> Observable<Reducer<StartUpModel>> {
    return Observable.of(
      { model in model.copy(state: Failure(error)) },
      { model in model.copy(state: idle) })
  }
}
