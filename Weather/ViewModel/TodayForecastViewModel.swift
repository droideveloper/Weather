//
//  TodayForecastViewModel.swift
//  Weather
//
//  Created by Fatih Şen on 13.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import MVICocoa

class TodayForecastViewModel: BaseViewModel<TodayForecastModel> {
	
	weak var view: TodayForecastController?
	
	init(view: TodayForecastController) {
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
