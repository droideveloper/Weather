//
//  TodayForecastViewModel.swift
//  Weather
//
//  Created by Fatih Şen on 12.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TodayForecastViewModel: ViewModelable {
	
	typealias M = TodayForecastModel
	
	fileprivate let intent = PublishRelay<Intent>()
	
	fileprivate func storage() -> Observable<Reducer<TodayForecastModel>> {
		return intent.asObservable()
			.toReducer()
	}
	
	func store() -> Observable<TodayForecastModel> {
		
	}
	
	func attah() {
		
	}
	
	func detach() {
		
	}
	
	func accept(intent: Intent) {
		
	}
}
