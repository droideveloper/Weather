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
		
  @IBOutlet var viewProgress: UIActivityIndicatorView!
  @IBOutlet weak var viewImageBackground: UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setUp()
		viewModel.attach()
	}
	
	func setUp() {
		viewModel.view = self

	}
	
	override func viewDidDisappear(_ animated: Bool) {
		viewModel.view = nil
		super.viewDidDisappear(animated)
	}
	
	func render(model: TodayForecastModel) {
    var progresState: Bool = false
		if model.syncState is IdleState {
      render(todayForecast: model.data)
		} else if model.syncState is ProcessState {
			progresState = true
		} else if model.syncState is ErrorState {
      // TODO show error case to use
		}
    changeProgress(progresState)
	}
	
	func viewEvents() -> Observable<Event> {
		return events.share()
	}
  
  private func render(todayForecast: TodayForecast) {
    // background image rendered
    viewImageBackground.image = UIImage(named: todayForecast.name.lowercased())
  }
  
  private func changeProgress(_ state: Bool) {
    if state {
      self.viewProgress.alpha = 1
      self.viewProgress.startAnimating()
    } else {
      self.viewProgress.stopAnimating()
      self.viewProgress.alpha = 0
    }
  }
}
