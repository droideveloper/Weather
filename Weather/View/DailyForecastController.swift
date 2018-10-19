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

class DailyForecastController: UITableViewController, View {
  typealias Model = DailyForecastModel
  
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
    
    self.refreshControl = UIRefreshControl()
    self.refreshControl?.tintColor = UIColor.parse(0x0054ED)
    self.refreshControl?.setNeedsDisplay() // will invaldiate it stage one

    
    if let refreshControl = self.refreshControl {
      // will bind this for me
      disposeBag += refreshControl.rx.controlEvent(.valueChanged)
        .map { _ in refreshControl.isRefreshing }
        .filter { $0 == true }
        .map { _ in LoadDailyForecastEvent() }
        .subscribe(onNext: events.accept)
      
      disposeBag += viewModel.state()
        .map {
          if let refresh = $0 as? ProcessState {
            return refresh == refresh
          }
          return false
        }
        .do(onNext: { [weak weakSelf = self] _ in weakSelf?.dataSet.clear() })
        .subscribe(refreshControl.rx.isRefreshing)
    }
    // register our xib file for dequeue
    self.tableView.register(UINib(nibName: "DailyForecastCell", bundle: Bundle.main), forCellReuseIdentifier: DailyForecastDataSource.DAILY_FORECASST_CELL)
    // we will set style of
    self.tableView.separatorStyle = .none
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
