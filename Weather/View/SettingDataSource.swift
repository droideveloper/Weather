//
//  SettingDataSource.swift
//  Weather
//
//  Created by Fatih Şen on 23.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import UIKit

class SettingDataSource: BaseTableDataSource<Settingable> {
	
	static let settingCell = "kSettingCell"
	
	override init(dataSet: ObservableList<Settingable>) {
		super.init(dataSet: dataSet)
	}
	
	override func indentifierForIndexPath(_ indexPath: IndexPath) -> String {
		return SettingDataSource.settingCell
	}
}
