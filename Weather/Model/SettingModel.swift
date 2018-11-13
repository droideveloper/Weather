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
	
	public static let empty = SettingModel(state: idle, data: [], selection: SettingableModel.empty)
	
	public var state: SyncState
	public var data: [Settingable]
	public var selection: SettingableModel
	
	public func copy(state: SyncState? = nil, data: [Settingable]? = nil) -> SettingModel {
		return copy(state: state, data: data, selection: self.selection)
	}
	
	public func copy(state: SyncState? = nil, data: [Settingable]? = nil, selection: SettingableModel? = nil) -> SettingModel {
		return SettingModel(state: state ?? self.state, data: data ?? self.data, selection: selection ?? self.selection)
	}
}
