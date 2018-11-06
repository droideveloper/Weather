//
//  DailyForecastModel.swift
//  Weather
//
//  Created by Fatih Şen on 12.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import MVICocoa

public struct DailyForecastModel: Model {
	public typealias Entity = [DailyForecast]
	
	public static let empty = DailyForecastModel(syncState: idle, data: [DailyForecast]())
	
	public var syncState: SyncState
	public var data: [DailyForecast]
  
  public func copy(syncState: SyncState? = nil, data: [DailyForecast]? = nil) -> DailyForecastModel {
    return DailyForecastModel(syncState: syncState ?? self.syncState, data: data ?? self.data)
  }
}
