//
//  LoadLengthSettingEvent.swift
//  Weather
//
//  Created by Fatih Şen on 10.11.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import MVICocoa
import Swinject

class LoadLengthSettingEvent: Event {

  override func toIntent(container: Container?) -> Intent {
		if let userDefaultsRepository = container?.resolve(UserDefaultsRepository.self) {
    	return LoadLengthSettingIntent(userDefaultsRepository: userDefaultsRepository)
		}
		return super.toIntent(container: container)
  }
}
