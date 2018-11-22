//
//  LoadCityEvent.swift
//  Weather
//
//  Created by Fatih Şen on 6.11.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import MVICocoa
import Swinject

class LoadSelectedCityEvent: Event {

  override func toIntent(container: Container?) -> Intent {
		if let userDefaultsRepository = container?.resolve(UserDefaultsRepository.self), let cityRepository = container?.resolve(CityRepository.self) {
			return LoadSelectedCityIntent(cityRepository: cityRepository, userDefaultsRepository: userDefaultsRepository)
		}
    return super.toIntent(container: container) // will provide nothing intent if there is no intent relative to this event 
  }
}
