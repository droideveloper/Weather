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
  private let fileManaeger = FileManager.default
  private let fileRepository: FileRepository
	
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
      if let url = fileRepository.cityUrl {
        return !fileManaeger.fileExists(atPath: url.path) // if not exists we read from bundled file...
      }
      return true
		}
	}
  
  init(fileRepository: FileRepository) {
    self.fileRepository = fileRepository
  }
}
