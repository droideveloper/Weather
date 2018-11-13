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

class SettingController: BaseViewController<SettingModel, SettingViewModel>, UITableViewDelegate {
	
	@IBOutlet private weak var viewTable: UITableView!
	@IBOutlet private weak var viewPicker: UIPickerView!
	
	private lazy var dataSet = {
		return ObservableList<Settingable>()
	}()
	
	private lazy var dataSource = {
		return SettingDataSource(dataSet: dataSet)
	}()
	
	private let lengthData = ["Metric", "Imperial"]
	private let temperetureData = ["Celsius", "Fahrenheit"]
	
	private var selectionDisposable: Disposable = Disposables.create()
	
	private var selectionMode = -1
	// cosntants
	private let lengthSelection = 0
	private let temperetureSelection = 1
	
	override func setUp() {
		viewPicker.alpha = 0 // hide view now
		
		viewTable.register(UINib(nibName: "SettingCell", bundle: Bundle.main), forCellReuseIdentifier: SettingDataSource.settingCell)
		viewTable.separatorStyle = .none
		viewTable.dataSource = dataSource
		viewTable.delegate = self
	}
	
	override func attach() {
		super.attach()
		dataSet.register(viewTable)
		
		checkIfInitialLoadNeeded()
	}
	
	override func render(model: SettingModel) {
		if model.state is Idle {
			if (!model.data.isEmpty) {
				dataSet.append(model.data)
			}
			if (!model.dataSet.isEmpty) {
				// bind data
				_ = Observable.of(model.dataSet)
					.bind(to: viewPicker.rx.itemTitles) { _, item in item }
				// selection ref
				selectionDisposable.dispose()
				selectionDisposable = viewPicker.rx.modelSelected(String.self)
					.map { $0.first ?? String.empty }
					.filter { $0 != String.empty }
					.map {  }
					.subscribe(onNext: { index in } ) // 
			}
		}
	}
  
  override func viewDidDisappear(_ animated: Bool) {
		dataSet.unregister(viewTable)
		super.viewDidDisappear(animated)
  }
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		viewPicker.alpha = 1
		let position = indexPath.row
		if position == lengthSelection {
			selectionMode = lengthSelection
		} else if position == temperetureSelection {
			selectionMode = temperetureSelection
		} else {
			selectionMode = -1
		}
		bindData(Observable.of(selectionMode == lengthSelection ? lengthData : temperetureData))
	}
	
	private func checkIfInitialLoadNeeded() {
		if dataSet.isEmpty {
			accept(LoadSettingEvent())
		}
	}
	
	private func bindData(_ dataSource: Observable<[String]>) {
		disposeBag += dataSource.bind(to: viewPicker.rx.itemTitles) {_, item in item }
		disposeBag += viewPicker.rx.modelSelected(String.self).subscribe(onNext: optionSelected(_ :))
		if let userDefaultsRepository = container?.resolve(UserDefaultsRepository.self) {
			if selectionMode == lengthSelection {
				viewPicker.selectRow(userDefaultsRepository.selectedUnitOfLength, inComponent: 0, animated: true)
			} else if selectionMode == temperetureSelection {
				viewPicker.selectRow(userDefaultsRepository.selectedUnitOfTemperature, inComponent: 0, animated: true)
			}
		}
	}
	
	private func optionSelected(_ options: [String]) {
		if var userDefaultsRepository = container?.resolve(UserDefaultsRepository.self) {
			let selection = options.first ?? String.empty
			var index: Int = -1
			if selectionMode == lengthSelection {
				userDefaultsRepository.selectedUnitOfLength = lengthData.firstIndex(of: selection) ?? 0
				index = 0
			} else if selectionMode == temperetureSelection {
				userDefaultsRepository.selectedUnitOfTemperature = temperetureData.firstIndex(of: selection) ?? 0
				index = 1
			}
			// invaldiate adapter
			dataSet.put(at: index, value: dataSet.get(index))
		}
		viewPicker.alpha = 0
	}
}
