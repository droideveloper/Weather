//
//  UpdateTemperatıureSettingEvent.swift
//  Weather
//
//  Created by Fatih Şen on 12.11.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import Swinject
import MVICocoa

class UpdateTemperatureSettingEvent: Event {
	
	private let position: Int
	private let data: Array<Settingable>
	
	init(position: Int, data: Array<Settingable>) {
		self.position = position
		self.data = data
	}
	
	override func toIntent(container: Container?) -> Intent {
		if let userDefaultsRepository = container?.resolve(UserDefaultsRepository.self) {
			return UpdateTemperatureSettingIntent(userDefaultsRepository: userDefaultsRepository, position: position, data: data)
		}
		return super.toIntent(container: container)
	}
}
