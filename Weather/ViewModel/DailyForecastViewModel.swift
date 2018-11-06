//
//  DailyForecastViewModel.swift
//  Weather
//
//  Created by Fatih Şen on 15.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import MVICocoa

class DailyForecastViewModel: BaseViewModel<DailyForecastModel> {
	
	weak var view: DailyForecastController?
	
	init(view: DailyForecastController) {
		self.view = view
	}
	
	override func attach() {
		super.attach()
		guard let view = view else { return }
		
		disposeBag += view.viewEvents()
			.toIntent(view.container)
			.subscribe(onNext: accept(_ :))
	}
}
