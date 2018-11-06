//
//  DailyForecastDataSource.swift
//  Weather
//
//  Created by Fatih Şen on 15.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import UIKit
import MVICocoa

class DailyForecastDataSource: NSObject, UITableViewDataSource {

	static let dailyForecastCell = "kDailyForecastCell"
	
	private let dataSet: ObservableList<DailyForecast>
	
  init(dataSet: ObservableList<DailyForecast>) {
    self.dataSet = dataSet
  }
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataSet.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: DailyForecastDataSource.dailyForecastCell)
		if let cell = cell as? DailyForecastCell {
			cell.bind(entity: dataSet.get(indexPath.row))
			return cell
		}
		fatalError("we can not recognize cell type")
	}
}
