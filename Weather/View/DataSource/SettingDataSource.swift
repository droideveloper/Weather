//
//  SettingDataSource.swift
//  Weather
//
//  Created by Fatih Şen on 23.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import UIKit
import MVICocoa

class SettingDataSource: TableDataSource<Settingable> {
	
	private let settingCell = String(describing: SettingCell.self)

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func bind(_ cell: UITableViewCell, _ item: Settingable) {
		if let cell = cell as? SettingCell {
			cell.bind(entity: item)
		}
	}
	
	override func identifierAt(_ indextPath: IndexPath) -> String {
		return settingCell
	}
}
