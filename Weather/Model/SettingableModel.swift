//
//  SettingableModel.swift
//  Weather
//
//  Created by Fatih Şen on 13.11.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import MVICocoa

public struct SettingableModel {

	public static let empty = SettingableModel(data: Settingable.empty, position: -1, dataSet: [])
	
	public var data: Settingable
	public var position: Int
	public var dataSet: [String]
	
	public func copy(data: Settingable? = nil, position: Int? = nil, dataSet: [String]? = nil) -> SettingableModel {
		return SettingableModel(data: data ?? self.data, position: position ?? self.position, dataSet: dataSet ?? self.dataSet)
	}
}
