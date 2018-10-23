//
//  DailyForecastDataSource.swift
//  Weather
//
//  Created by Fatih Şen on 15.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import UIKit

class DailyForecastDataSource: BaseTableDataSource<DailyForecast> {

	static let dailyForecastCell = "kDailyForecastCell"
  
  override init(dataSet: ObservableList<DailyForecast>) {
    super.init(dataSet: dataSet)
  }
	
	override func indentifierForIndexPath(_ indexPath: IndexPath) -> String {
		return DailyForecastDataSource.dailyForecastCell
	}
}
