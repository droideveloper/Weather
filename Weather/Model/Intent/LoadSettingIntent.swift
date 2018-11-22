//
//  LoadSettingIntent.swift
//  Weather
//
//  Created by Fatih Şen on 10.11.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import MVICocoa

class LoadSettingIntent: ReducerIntent<SettingModel> {

	private let userDefaultsRepository: UserDefaultsRepository
	
	init(userDefaultsRepository: UserDefaultsRepository) {
    self.userDefaultsRepository = userDefaultsRepository
  }

  override func invoke() -> Reducer<SettingModel> {
		let data = [LengthSetting(userDefaultsRepository: userDefaultsRepository), TemperetureSetting(userDefaultsRepository: userDefaultsRepository)]
		return { model in model.copy(state: idle, data: data) }
  }
}
