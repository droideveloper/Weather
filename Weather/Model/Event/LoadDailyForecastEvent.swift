//
//  LoadDailyForecastEvent.swift
//  Weather
//
//  Created by Fatih Şen on 15.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import Swinject

class LoadDailyForecastEvent: Event {
  
  override func toIntent(container: Container?) -> Intent {
    if let dailyForecastRepository = container?.resolve(DailyForecastRepository.self) {
      return LoadDailyForecastIntent(dailyForecastRepository: dailyForecastRepository)
    }
    return super.toIntent(container: container)
  }
}
