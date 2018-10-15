//
//  TodayForecastModel.swift
//  Weather
//
//  Created by Fatih Şen on 12.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

public struct TodayForecastModel: Model {
	
	public static let initState = TodayForecastModel(syncState: IdleState(), data: TodayForecast.empty)
	
	var syncState: SyncState
	var data: TodayForecast
	
	func copy(syncState: SyncState? = nil, data: TodayForecast? = nil) -> TodayForecastModel {
		return TodayForecastModel(syncState: syncState ?? self.syncState, data: data ?? self.data)
	}
}
