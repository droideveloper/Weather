//
//  LoadTemperatureSettingIntent.swift
//  Weather
//
//  Created by Fatih Şen on 10.11.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift
import MVICocoa

class LoadTemperatureSettingIntent: ObservableIntent<SettingModel> {

	private let userDefaultsRepository: UserDefaultsRepository
	
	init(userDefaultsRepository: UserDefaultsRepository) {
		self.userDefaultsRepository = userDefaultsRepository
	}
	
  override func invoke() -> Observable<Reducer<SettingModel>> {
		let position = userDefaultsRepository.selectedUnitOfTemperature
		let dataSet = ["Celsius", "Fahrenheit"]
		return Observable.of(
			{ model in model.copy(state: loadSetting, selection: model.selection.copy(position: position, dataSet: dataSet)) },
			{ model in model.copy(state: idle, selection: SettingableModel.empty) })
  }
}
