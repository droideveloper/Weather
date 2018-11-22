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

class SettingDataSource: NSObject, UITableViewDataSource {
	
	static let settingCell = "kSettingCell"
	
	private let dataSet: ObservableList<Settingable>
	
	init(dataSet: ObservableList<Settingable>) {
		self.dataSet = dataSet
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSet.count
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: SettingDataSource.settingCell)
		if let cell = cell as? SettingCell {
			cell.bind(entity: dataSet.get(indexPath.row))
			return cell
		}
		fatalError("error we can not recognize setting cell")
	}
}
