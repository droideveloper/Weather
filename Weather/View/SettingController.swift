//
//  SettingController.swift
//  Weather
//
//  Created by Fatih Şen on 19.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
import MVICocoa

class SettingController: BaseViewController<SettingModel, SettingViewModel> {
	
	@IBOutlet private weak var viewTable: UITableView!
	@IBOutlet private weak var viewPicker: UIPickerView!
	
	private lazy var dataSet = {
		return ObservableList<Settingable>()
	}()
	
	private lazy var dataSource = {
		return SettingDataSource(dataSet: dataSet)
	}()
	
	private var selectionDisposable = Disposables.create()
	private var dataSourceDisposalbe = Disposables.create()
	
	override func setUp() {
		viewPicker.alpha = 0 // hide view now
		
		viewTable.register(UINib(nibName: "SettingCell", bundle: Bundle.main), forCellReuseIdentifier: SettingDataSource.settingCell)
		viewTable.separatorStyle = .none
		viewTable.dataSource = dataSource
	}
	
	override func attach() {
		super.attach()
		dataSet.register(viewTable)
		
		disposeBag += viewTable.rx.itemSelected
			.map { item in item.row }
			.map { index in self.dataSet.get(index) }
			.map { setting in
				if setting is LengthSetting {
					return LoadLengthSettingEvent()
				}
				return LoadTemperatureSettingEvent()
			}
			.subscribe(onNext: accept(_ :))
		
		checkIfInitialLoadNeeded()
	}
	
	override func render(model: SettingModel) {
		if model.state is Idle {
			if (!model.data.isEmpty) {
				dataSet.append(model.data)
			}
		} else if let state = model.state as? Operation {
			if state == loadSetting {
				// grab data ref
				let data = model.selection.dataSet
				if (!data.isEmpty) {
					viewPicker.alpha = 1
					// bind data
					dataSourceDisposalbe.dispose()
					dataSourceDisposalbe = Observable.of(data)
						.bind(to: viewPicker.rx.itemTitles) { _, item in item }
					// selection ref
					selectionDisposable.dispose()
					selectionDisposable = viewPicker.rx.modelSelected(String.self)
						.map { $0.first ?? String.empty }
						.filter { $0 != String.empty }
						.map { item in model.selection.dataSet.indexOf { s in s == item } }
						.subscribe(onNext: { [weak weakSelf = self] index in
							weakSelf?.viewPicker.alpha = 0
							if index != -1 {
								if model.selection.data is LengthSetting {
									weakSelf?.accept(UpdateLengthSettingEvent(position: index, data: weakSelf?.dataSet.asArray() ?? []))
								} else if model.selection.data is TemperetureSetting {
									weakSelf?.accept(UpdateTemperatureSettingEvent(position: index, data: weakSelf?.dataSet.asArray() ?? []))
								}
							}
						})
					
					// select value from user
					if model.selection.position != -1 {
						disposeBag += Observable.of(model.selection.position)
							.delay(TimeInterval(0.5), scheduler: MainScheduler.asyncInstance)
							.subscribe(onNext: { [weak weakSelf = self] index in
								weakSelf?.viewPicker.selectRow(index, inComponent: 0, animated: true)
							})
					}
				}
			} else if state == selectSetting {
				let position = model.selection.position
				if position != -1 {
					dataSet.put(at: position, value: dataSet.get(position))
				}
			}
		}
	}
  
  override func viewDidDisappear(_ animated: Bool) {
		dataSet.unregister(viewTable)
		dataSourceDisposalbe.dispose()
		selectionDisposable.dispose()
		super.viewDidDisappear(animated)
  }
	
	private func checkIfInitialLoadNeeded() {
		if dataSet.isEmpty {
			accept(LoadSettingEvent())
		}
	}
}
