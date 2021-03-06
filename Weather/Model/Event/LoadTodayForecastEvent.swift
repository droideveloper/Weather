//
//  LoadTodayForecastEvent.swift
//  Weather
//
//  Created by Fatih Şen on 12.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import MVICocoa
import Swinject

class LoadTodayForecastEvent: Event {
  
  override func toIntent(container: Container?) -> Intent {
    if let todayForecastRepository = container?.resolve(TodayForecastRepository.self) {
      return LoadTodayForecastIntent(todayForecastRepository: todayForecastRepository)
    }
    return super.toIntent(container: container)
  }
}
