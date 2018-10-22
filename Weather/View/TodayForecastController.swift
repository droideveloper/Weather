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
    
    // bind animating state from coming model state
    disposeBag += viewModel.state()
      .map {
        if let state = $0 as? ProcessState {
          return state == refresh
        }
        return false
      }
      .subscribe(viewProgress.rx.isAnimating)
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		viewModel.view = nil // remove view referance when this is detached
		super.viewDidDisappear(animated)
	}
	
	func render(model: TodayForecastModel) {
		if model.syncState is IdleState {
      render(todayForecast: model.data)
		} else if model.syncState is ProcessState {
		} else if model.syncState is ErrorState {
      if let errorState = model.syncState as? ErrorState {
        showError(error: errorState.error)
      }
		}
	}
	
	func viewEvents() -> Observable<Event> {
		return events.share()
	}
  
  private func render(todayForecast: TodayForecast) {
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
