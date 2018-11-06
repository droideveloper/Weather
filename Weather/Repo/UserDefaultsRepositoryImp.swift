//
//  UserDefaultsRepositoryImp.swift
//  Weather
//
//  Created by VNGRS on 9.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import MVICocoa

class UserDefaultsRepositoryImp: UserDefaultsRepository {
	
	private let keyCityFile = "cities.json"
	
	private let keySelectedCity = "key.selected.city"
	private let keySelectedUnitOfLength = "key.selected.unit.of.length"
	private let keySelectedUnitOfTemperature = "key.selected.unit.of.temperature"
	private let keyShouldReadFromLocalRepository = "key.should.read.from.local.repository"
	
	private let userDefaults = UserDefaults.standard
  private let fileManaeger = FileManager.default
  private let fileRepository: FileRepository
	
	var selectedCityId: Int {
		get {
      return userDefaults.integer(forKey: keySelectedCity)
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
			let url = fileRepository.file(for: keyCityFile)
      if let url = url {
        return !fileManaeger.fileExists(atPath: url.path) // if not exists we read from bundled file...
      }
      return true
		}
	}
  
  init(fileRepository: FileRepository) {
    self.fileRepository = fileRepository
  }
}
