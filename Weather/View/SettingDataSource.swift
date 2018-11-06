//
//  SettingDataSource.swift
//  Weather
//
//  Created by Fatih Şen on 23.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
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
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
	}
}
