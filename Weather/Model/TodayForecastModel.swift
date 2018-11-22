//
//  TodayForecastModel.swift
//  Weather
//
//  Created by Fatih Şen on 12.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import MVICocoa

public struct TodayForecastModel: Model {
	public typealias Entity = TodayForecast
	
	public static let empty = TodayForecastModel(state: idle, data: TodayForecast.empty, city: City.empty)
	
	public var state: SyncState
	public var data: TodayForecast
	public var city: City
	
	public func copy(state: SyncState? = nil, data: TodayForecast? = nil, city: City? = nil) -> TodayForecastModel {
		return TodayForecastModel(state: state ?? self.state, data: data ?? self.data, city: city ?? self.city)
	}
	
  public func copy(state: SyncState? = nil, data: TodayForecast? = nil) -> TodayForecastModel {
		return TodayForecastModel(state: state ?? self.state, data: data ?? self.data, city: self.city)
  }
}
