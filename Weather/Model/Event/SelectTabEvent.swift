//
//  SelectTabEvent.swift
//  Weather
//
//  Created by Fatih Şen on 18.11.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import MVICocoa
import Swinject

class SelectTabEvent: Event {

	private let tab: Tab
	
	init(tab: Tab) {
    self.tab = tab
  }

  override func toIntent(container: Container?) -> Intent {
		return SelectTabIntent(tab: tab)
  }
}
