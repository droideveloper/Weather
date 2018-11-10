//
//  LoadLengthSettingIntent.swift
//  Weather
//
//  Created by Fatih Şen on 10.11.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import MVICocoa

class LoadLengthSettingIntent: ReducerIntent<SettingModel> {
	
  override func invoke() -> Reducer<SettingModel> {
		let dataSet = ["Metric", "Imperial"]
		return { model in model.copy(state: idle, dataSet: dataSet) }
  }
}
