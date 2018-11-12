//
//  LoadTemperatureSettingEvent.swift
//  Weather
//
//  Created by Fatih Şen on 10.11.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import MVICocoa
import Swinject

class LoadTemperatureSettingEvent: Event {

  override func toIntent(container: Container?) -> Intent {
		if let userDefaultsRepository = container?.resolve(UserDefaultsRepository.self) {
    	return LoadTemperatureSettingIntent(userDefaultsRepository: userDefaultsRepository)
		}
		return super.toIntent(container: container)
  }
}
