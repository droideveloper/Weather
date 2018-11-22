//
//  UpdateSelectedCityIntent.swift
//  Weather
//
//  Created by Fatih Şen on 18.11.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import MVICocoa

class UpdateSelectedCityIntent: ReducerIntent<StartUpModel> {

	private let city: City
	private let userDefaultsRepository: UserDefaultsRepository
	
	init(city: City, userDefaultsRepository: UserDefaultsRepository) {
		self.city = city
		self.userDefaultsRepository = userDefaultsRepository
  }

  override func invoke() -> Reducer<StartUpModel> {
		var userDefaultsRepository = self.userDefaultsRepository
		userDefaultsRepository.selectedCityId = Int(city.id)
		return { model in model.copy(state: selectCity, data: [self.city]) }
  }
}
