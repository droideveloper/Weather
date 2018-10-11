//
//  UserDefaultsRepositoryImp.swift
//  Weather
//
//  Created by VNGRS on 9.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

class UserDefaultsRepositoryImp: UserDefaultsRepository {
	
	private let KEY_SELECTED_CITY = "key.selected.city"
	private let KEY_SELECTED_UNIT_OF_LENGTH = "key.selected.unit.of.length"
	private let KEY_SELECTED_UNIT_OF_TEMPERATURE = "key.selected.unit.of.temperature"
	private let KEY_SHOULD_READ_FROM_LOCAL_REPOSITORY = "key.should.read.from.local.repository"
	
	private let userDefaults = UserDefaults.standard
	
	var selectedCityId: Int {
		get {
			return userDefaults.integer(forKey: KEY_SELECTED_CITY)
		}
		set {
			userDefaults.set(newValue, forKey: KEY_SELECTED_CITY)
		}
	}
	
	var selectedUnitOfLength: Int {
		get {
			return userDefaults.integer(forKey: KEY_SELECTED_UNIT_OF_LENGTH)
		}
		set {
			userDefaults.set(newValue, forKey: KEY_SELECTED_UNIT_OF_LENGTH)
		}
	}
	
	var selectedUnitOfTemperature: Int {
		get {
			return userDefaults.integer(forKey: KEY_SELECTED_UNIT_OF_TEMPERATURE)
		}
		set {
			userDefaults.set(newValue, forKey: KEY_SELECTED_UNIT_OF_TEMPERATURE)
		}
	}
	
	var shouldReadFromLocalRepository: Bool {
		get {
			return userDefaults.bool(forKey: KEY_SHOULD_READ_FROM_LOCAL_REPOSITORY)
		}
		set {
			userDefaults.set(newValue, forKey: KEY_SHOULD_READ_FROM_LOCAL_REPOSITORY)
		}
	}
}
