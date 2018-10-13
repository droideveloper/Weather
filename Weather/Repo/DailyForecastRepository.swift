//
//  DailyForecastRepository.swift
//  Weather
//
//  Created by Fatih Şen on 12.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift

protocol DailyForecastRepository {
	
	func loadDailyForecast() -> Observable<[DailyForecast]>
}