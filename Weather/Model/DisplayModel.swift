//
//  DisplayModel.swift
//  Weather
//
//  Created by Fatih Şen on 10.11.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import MVICocoa

public struct DisplayModel: Model {
	public typealias Entity = Display
	
	public static let empty = DisplayModel(state: idle, data: .todayForecast)
	
	public var state: SyncState
	public var data: Display
	
	public func copy(state: SyncState? = nil, data: Display? = nil) -> DisplayModel {
		return DisplayModel(state: state ?? self.state, data: data ?? self.data)
	}
}
