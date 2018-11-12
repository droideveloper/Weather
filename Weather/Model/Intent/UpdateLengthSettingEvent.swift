//
//  UpdateLengthSettingEvent.swift
//  Weather
//
//  Created by Fatih Şen on 12.11.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import MVICocoa

class UpdateLengthSettingEvent: ReducerIntent<SettingModel> {

	private let userDefaultsRepository: userDefaultsRepository
	
	init(userDefaultsRepository: UserDefaultsRepository) {
    self.userDefaultsRepository = userDefaultsRepository
  }

  override func invoke() -> Reducer<SettingModel> {
    return { model in model.copy(state: idle) }
  }
}