//
//  DailyForecastController.swift
//  Weather
//
//  Created by Fatih Şen on 15.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class DailyForecastController: UIViewController, View {
  typealias Model = DailyForecastModel
  
  private let viewModel = DailyForecastViewModel()
  private let disposeBag = DisposeBag()
  private let events = PublishRelay<Event>()

	@IBOutlet private var viewTable: UITableView!
	@IBOutlet private var viewProgress: UIActivityIndicatorView!
	
  private let dataSet = ObservableList<DailyForecast>()
  private lazy var dataSource = {
    return DailyForecastDataSource(dataSet: dataSet)
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
		setUp()
		self.viewModel.attach()
    
    checkIfInitialLoadNeeded()
  }
	
	func setUp() {
		self.viewModel.view = self
    dataSet.register(self.viewTable)
		
		disposeBag += viewModel.state()
			.map {
				if let state = $0 as? ProcessState {
					return state == refresh
				}
				return false
			}
			.do(onNext: invaldiateProgress(_ :))
			.subscribe(viewProgress.rx.isAnimating)
		
    // register our xib file for dequeue
    self.viewTable.register(UINib(nibName: "DailyForecastCell", bundle: Bundle.main), forCellReuseIdentifier: DailyForecastDataSource.DAILY_FORECASST_CELL)
    // we will set style of
    self.viewTable.separatorStyle = .none
    self.viewTable.dataSource = dataSource
    
    disposeBag += viewModel.store()
      .subscribe(onNext: render(model:))
	}
	
  func render(model: DailyForecastModel) {
    if model.syncState is IdleState {
      render(data: model.data)
    } else if model.syncState is ProcessState {
      // do we need any thing in here when state is process
    } else if model.syncState is ErrorState {
      if let errorState = model.syncState as? ErrorState {
        showError(error: errorState.error)
      }
    }
  }
	
	override func viewDidDisappear(_ animated: Bool) {
    dataSet.unregister(self.viewTable)
		super.viewDidDisappear(animated)
	}
  
  func viewEvents() -> Observable<Event> {
    return events.asObservable()
  }
  
  private func render(data: [DailyForecast]) {
    if !data.isEmpty {
      dataSet.append(data)
    }
  }
  
  private func checkIfInitialLoadNeeded() {
    if dataSet.isEmpty {
      events.accept(LoadDailyForecastEvent())
    }
  }
	
	private func invaldiateProgress(_ visible: Bool) {
		viewProgress.alpha = visible ? 1 : 0
	}
}
