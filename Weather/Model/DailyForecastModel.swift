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
	
	public static let empty = DailyForecastModel(state: idle, data: [])
	
	public var state: SyncState
	public var data: [DailyForecast]
  
  public func copy(state: SyncState? = nil, data: [DailyForecast]? = nil) -> DailyForecastModel {
    return DailyForecastModel(state: state ?? self.state, data: data ?? self.data)
  }
}
