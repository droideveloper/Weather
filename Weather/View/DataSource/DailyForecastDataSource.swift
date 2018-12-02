//
//  DailyForecastDataSource.swift
//  Weather
//
//  Created by Fatih Şen on 15.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import UIKit
import MVICocoa

class DailyForecastDataSource: TableDataSource<DailyForecast> {

	static let dailyForecastCell = "kDailyForecastCell"
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func bind(_ cell: UITableViewCell, _ item: DailyForecast) {
		if let cell = cell as? DailyForecastCell {
			cell.bind(entity: item)
		}
	}
	
	override func identifierAt(_ indextPath: IndexPath) -> String {
		return DailyForecastDataSource.dailyForecastCell
	}
}
