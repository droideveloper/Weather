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
  
  @IBOutlet var tableView: UITableView!
  
  private let viewModel = DailyForecastViewModel()
  private let disposeBag = DisposeBag()
  private let events = PublishRelay<Event>()
  
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
    dataSet.register(self.tableView)
    
    self.tableView.dataSource = dataSource
    
    disposeBag += viewModel.store()
      .subscribe(onNext: render(model:))
    
	}
	
  func render(model: DailyForecastModel) {
    if model.syncState is IdleState {
      render(data: model.data)
    } else if model.syncState is ProcessState {
    } else if model.syncState is ErrorState {
      // TODO here
    }
  }
	
	override func viewDidDisappear(_ animated: Bool) {
    dataSet.unregister(self.tableView)
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
}
