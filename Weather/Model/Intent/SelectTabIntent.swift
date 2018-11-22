//
//  SelectTabIntent.swift
//  Weather
//
//  Created by Fatih Şen on 18.11.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import MVICocoa

class SelectTabIntent: ReducerIntent<MainModel> {

	private let tab: Tab
	
	init(tab: Tab) {
    self.tab = tab
  }

  override func invoke() -> Reducer<MainModel> {
		return { model in model.copy(state: selectTab, data: [self.tab]) }
  }
}
