//
//  SettingModel.swift
//  Weather
//
//  Created by Fatih Şen on 10.11.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import MVICocoa

public struct SettingModel: Model {
	public typealias Entity = [Settingable]
	
	public static let empty = SettingModel(state: idle, data: [], position: -1,  dataSet: [])
	
	public var state: SyncState
	public var data: [Settingable]
	public var position: Int
	public var dataSet: [String]
	
	public func copy(state: SyncState? = nil, data: [Settingable]? = nil) -> SettingModel {
		return copy(state: state, data: data, dataSet: [])
	}
	
	public func copy(state: SyncState? = nil, data: [Settingable]? = nil, dataSet: [String]? = nil, position: Int? = nil) -> SettingModel {
		return SettingModel(state: state ?? self.state, data: data ?? self.data, position: position ?? self.position, dataSet: dataSet ?? self.dataSet)
	}
}
