//
//  LoadCityEvent.swift
//  Weather
//
//  Created by Fatih Şen on 6.11.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import MVICocoa
import Swinject

class LoadCityEvent: Event {

  override func toIntent(container: Container?) -> Intent {
		if let userDefaultsRepository = container?.resolve(UserDefaultsRepository.self), let cityRepository = container?.resolve(CityRepository.self) {
			return LoadCityIntent(cityRepository: cityRepository, userDefaultsRepository: userDefaultsRepository)
		}
    return super.toIntent(container: container) // will provide nothing intent if there is no intent relative to this event 
  }
}
