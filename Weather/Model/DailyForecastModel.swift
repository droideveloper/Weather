//
//  DailyForecastModel.swift
//  Weather
//
//  Created by Fatih Şen on 12.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

public struct DailyForecastModel: Model {
	
	static let initState = DailyForecastModel(syncState: idle, data: [DailyForecast]())
	
	var syncState: SyncState
	var data: [DailyForecast]
  
  func copy(syncState: SyncState? = nil, data: [DailyForecast]? = nil) -> DailyForecastModel {
    return DailyForecastModel(syncState: syncState ?? self.syncState, data: data ?? self.data)
  }
}
