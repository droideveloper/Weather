//
//  TodayForecastController.swift
//  Weather
//
//  Created by Fatih Şen on 13.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class TodayForecastController: UIViewController, View {
	typealias Model = TodayForecastModel
	
	private let viewModel = TodayForecastViewModel()
	private let disposeBag = DisposeBag()
	private let events = PublishRelay<Event>()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.view = self
		viewModel.attach()
		
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		viewModel.view = nil
		super.viewDidDisappear(animated)
	}
	
	func render(model: TodayForecastModel) {
		// do rendering in here
	}
	
	func viewEvents() -> Observable<Event> {
		return events.share()
	}
}