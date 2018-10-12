//
//  DailyForecastModel.swift
//  Weather
//
//  Created by Fatih Şen on 12.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

struct DailyForecastModel: Model {
	
	static let initState = DailyForecastModel(syncState: IdleState(), data: [DailyForecast]())
	
	var syncState: SyncState
	var data: [DailyForecast]
}
