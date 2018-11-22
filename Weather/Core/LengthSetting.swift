//
//  LengthSetting.swift
//  Weather
//
//  Created by Fatih Şen on 23.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation

class LengthSetting: Settingable {
	
	private let userDefaultsRepository: UserDefaultsRepository
	
	init(userDefaultsRepository: UserDefaultsRepository) {
		self.userDefaultsRepository = userDefaultsRepository
	}
	
	override var title: String {
		get {
			return "Unit Of Length"
		}
	}
	
	override var value: String {
		get {
			switch userDefaultsRepository.selectedUnitOfLength {
				case UnitOfLength.metric.rawValue:
					return "Metric"
				case UnitOfLength.imperial.rawValue:
					return "Imperial"
				default:
					return "Unknown"
			}
		}
	}
}
