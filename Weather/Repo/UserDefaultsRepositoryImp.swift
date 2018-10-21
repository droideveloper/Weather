//
//  UserDefaultsRepositoryImp.swift
//  Weather
//
//  Created by VNGRS on 9.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

class UserDefaultsRepositoryImp: UserDefaultsRepository {
	
	private let keySelectedCity = "key.selected.city"
	private let keySelectedUnitOfLength = "key.selected.unit.of.length"
	private let keySelectedUnitOfTemperature = "key.selected.unit.of.temperature"
	private let keyShouldReadFromLocalRepository = "key.should.read.from.local.repository"
	
	private let userDefaults = UserDefaults.standard
	
	var selectedCityId: Int {
		get {
      let activeCityId = userDefaults.integer(forKey: keySelectedCity)
      if activeCityId == 0 {
        return 3067696 // prague
      }
			return activeCityId
		}
		set {
			userDefaults.set(newValue, forKey: keySelectedCity)
		}
	}
	
	var selectedUnitOfLength: Int {
		get {
			return userDefaults.integer(forKey: keySelectedUnitOfLength)
		}
		set {
			userDefaults.set(newValue, forKey: keySelectedUnitOfLength)
		}
	}
	
	var selectedUnitOfTemperature: Int {
		get {
			return userDefaults.integer(forKey: keySelectedUnitOfTemperature)
		}
		set {
			userDefaults.set(newValue, forKey: keySelectedUnitOfTemperature)
		}
	}
	
	var shouldReadFromLocalRepository: Bool {
		get {
			return !userDefaults.bool(forKey: keyShouldReadFromLocalRepository)
		}
		set {
			userDefaults.set(newValue, forKey: keyShouldReadFromLocalRepository)
		}
	}
}
