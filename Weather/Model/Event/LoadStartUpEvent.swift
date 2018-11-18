//
//  LoadStartUpEvent.swift
//  Weather
//
//  Created by Fatih Şen on 18.11.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import MVICocoa
import Swinject

class LoadStartUpEvent: Event {

  override func toIntent(container: Container?) -> Intent {
		if let cityRepository = container?.resolve(CityRepository.self) {
			return LoadStartUpIntent(cityRepository: cityRepository)
		}
    return super.toIntent(container: container) // will provide nothing intent if there is no intent relative to this event 
  }
}
