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
  
  override func viewDidLoad() {
    super.viewDidLoad()
		setUp()
		self.viewModel.attach()
  }
	
	func setUp() {
		self.viewModel.view = self
    if let container = container {
      if let dataSource = container.resolve(DailyForecastDataSource.self) {
        self.tableView.dataSource = dataSource
        self.tableView.reloadData()
      }
    }
    if let dataSet = self.viewModel.dataSet {
      dataSet.register(self.tableView)
    }
	}
	
  func render(model: DailyForecastModel) {
    if model.syncState is IdleState {
      // TODO here
    } else if model.syncState is ProcessState {
      // TODO here
    } else if model.syncState is ErrorState {
      // TODO here
    }
  }
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
    if let dataSet = self.viewModel.dataSet {
      dataSet.unregister(self.tableView)
    }
	}
  
  func viewEvents() -> Observable<Event> {
    return events.asObservable()
  }
}
