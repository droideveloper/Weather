//
//  DailyForecastDataSource.swift
//  Weather
//
//  Created by Fatih Şen on 15.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import UIKit

class DailyForecastDataSource: NSObject, TableViewDataSource {
	typealias D = DailyForecast

	private let DAILY_FORECASST_CELL = "kDailyForecastCell"
	
	var dataSet: ObservableList<DailyForecast>
	
	init(dataSet: ObservableList<DailyForecast>) {
		self.dataSet = dataSet
	}
	
	func indentifierForIndexPath(_ indexPath: IndexPath) -> String {
		return DAILY_FORECASST_CELL
	}
	
	public func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSet.count
	}
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return cellFor(tableView, indexPath: indexPath)
	}
}
