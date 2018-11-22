//
//  DailyForecastController.swift
//  Weather
//
//  Created by Fatih Şen on 15.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import MVICocoa

class DailyForecastController: BaseViewController<DailyForecastModel, DailyForecastViewModel> {

	@IBOutlet private weak var viewTable: UITableView!
	@IBOutlet private weak var progress: UIActivityIndicatorView!
	
  private let dataSet = ObservableList<DailyForecast>()
  private lazy var dataSource = {
    return DailyForecastDataSource(dataSet: dataSet)
  }()
  
  // will held ref for our change or not
  private var selectedUnitTempereture: UnitOfTemperature = .celsius
	
	override func setUp() {
    // register our xib file for dequeue
    self.viewTable.register(UINib(nibName: "DailyForecastCell", bundle: Bundle.main), forCellReuseIdentifier: DailyForecastDataSource.dailyForecastCell)
    // we will set style of
    self.viewTable.separatorStyle = .none
    self.viewTable.dataSource = dataSource
	}
	
	override func attach() {
		super.attach()
		// bind data
		dataSet.register(self.viewTable)
		
		guard let viewModel = viewModel else { return }
		
		// bind progress
		disposeBag += viewModel.state()
			.map {
				if let state = $0 as? Operation {
					return state == refresh
				}
				return false
			}
			.do(onNext: invaldiateProgress(_ :))
			.subscribe(progress.rx.isAnimating)
		
		// bind model
		disposeBag += viewModel.store()
			.subscribe(onNext: render(model:))
		
		// check if measurement changed
		checkIfMeasumentChanged()
		// check if initial load is needed
		checkIfInitialLoadNeeded()
	}
	
  override func render(model: DailyForecastModel) {
    if model.state is Idle {
      render(data: model.data)
    } else if model.state is Operation {
      // do we need any thing in here when state is process
    } else if model.state is Failure {
      if let failure = model.state as? Failure {
        showError(failure.error)
      }
    }
  }
	
	override func viewDidDisappear(_ animated: Bool) {
    dataSet.unregister(self.viewTable)
		super.viewDidDisappear(animated)
	}
  
  private func render(data: [DailyForecast]) {
    if !data.isEmpty {
      dataSet.append(data)
    }
  }
  
  private func checkIfInitialLoadNeeded() {
    if dataSet.isEmpty {
      accept(LoadDailyForecastEvent())
    }
  }
	
	private func invaldiateProgress(_ visible: Bool) {
		progress.alpha = visible ? 1 : 0
	}
  
  private func checkIfMeasumentChanged() {
    if let userDefaultsRepository = container?.resolve(UserDefaultsRepository.self) {
      let newUnitTempereture = UnitOfTemperature(rawValue: userDefaultsRepository.selectedUnitOfTemperature) ?? .celsius
      if newUnitTempereture != selectedUnitTempereture {
        selectedUnitTempereture = newUnitTempereture
        BusManager.send(event: UnitOfTemperatureChangedEvent())
      }
    }
  }
}
