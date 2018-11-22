//
//  DailyForecastRepository.swift
//  Weather
//
//  Created by Fatih Şen on 12.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import RxSwift

protocol DailyForecastRepository {
	
	func loadDailyForecast() -> Observable<[DailyForecast]>
}
