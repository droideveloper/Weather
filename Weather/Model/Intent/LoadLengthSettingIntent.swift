//
//  LoadLengthSettingIntent.swift
//  Weather
//
//  Created by Fatih Şen on 10.11.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift
import MVICocoa

class LoadLengthSettingIntent: ObservableIntent<SettingModel> {
	
	private let userDefaultsRepository: UserDefaultsRepository
	
	init(userDefaultsRepository: UserDefaultsRepository) {
		self.userDefaultsRepository = userDefaultsRepository
	}
	
  override func invoke() -> Observable<Reducer<SettingModel>> {
		let dataSet = ["Metric", "Imperial"]
		let position = userDefaultsRepository.selectedUnitOfLength
		return Observable.of(
			{ model in model.copy(state: settingSelection, dataSet: dataSet, position: position) },
			{ model in model.copy(state: idle, data: [], dataSet: [], position: -1) })
  }
}
