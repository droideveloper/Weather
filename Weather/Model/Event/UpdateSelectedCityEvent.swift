//
//  UpdateSelectedCityEvent.swift
//  Weather
//
//  Created by Fatih Şen on 18.11.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import MVICocoa
import Swinject

class UpdateSelectedCityEvent: Event {

	private let city: City
	
	init(city: City) {
		self.city = city
  }

  override func toIntent(container: Container?) -> Intent {
		if let userDefaultsRepository = container?.resolve(UserDefaultsRepository.self) {
			return UpdateSelectedCityIntent(city: city, userDefaultsRepository: userDefaultsRepository)
		}
		return super.toIntent(container: container)
  }
}
