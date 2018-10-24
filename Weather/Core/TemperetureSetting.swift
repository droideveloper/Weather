//
//  TemperetureSetting.swift
//  Weather
//
//  Created by Fatih Şen on 23.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

class TemperetureSetting: Settingable {
	
	private let userDefaultsRepository: UserDefaultsRepository
	
	init(userDefaultsRepository: UserDefaultsRepository) {
		self.userDefaultsRepository = userDefaultsRepository
	}
	
	override var title: String {
		get {
			return "Unit of Tempereture"
		}
	}
	
	override var value: String {
		get {
			switch userDefaultsRepository.selectedUnitOfTemperature {
				case UnitOfTemperature.celsius.rawValue:
					return "Celsius"
				case UnitOfTemperature.fahrenheit.rawValue:
					return "Fahrenheit"
				default:
					return "Unknown"
			}
		}
	}
}
