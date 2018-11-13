//
//  UpdateLengthSettingEvent.swift
//  Weather
//
//  Created by Fatih Şen on 12.11.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import MVICocoa

class UpdateLengthSettingIntent: ReducerIntent<SettingModel> {

	private let userDefaultsRepository: UserDefaultsRepository
	private let position: Int
	private let data: Array<Settingable>
	
	init(userDefaultsRepository: UserDefaultsRepository, position: Int, data: Array<Settingable>) {
    self.userDefaultsRepository = userDefaultsRepository
		self.position = position
		self.data = data
  }

  override func invoke() -> Reducer<SettingModel> {
		var userDefaultsRepository = self.userDefaultsRepository
		userDefaultsRepository.selectedUnitOfLength = position
		return { model in model.copy(state: selectSetting, selection: model.selection.copy(data: self.data.first { s in s is LengthSetting }, position: self.position))  }
  }
}
