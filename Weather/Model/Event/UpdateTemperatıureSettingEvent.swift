//
//  UpdateTemperatıureSettingEvent.swift
//  Weather
//
//  Created by Fatih Şen on 12.11.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import Swinject
import MVICocoa

class UpdateTemperatureSettingEvent: Event {
	
	private let position: Int
	
	init(position: Int) {
		self.position = position
	}
	
	override func toIntent(container: Container?) -> Intent {
		
		return super.toIntent(container: container)
	}
}
