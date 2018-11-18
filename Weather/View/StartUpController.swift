//
//  StartUpController.swift
//  Weather
//
//  Created by Fatih Şen on 19.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import MVICocoa
import Swinject
import SwinjectStoryboard

class StartUpController: BaseViewController<StartUpModel, StartUpViewModel> {
  
  @IBOutlet private weak var viewImageBackground: UIImageView!
  @IBOutlet private weak var viewButtonSelectedCity: UIButton!
  @IBOutlet private weak var viewButtonContinue: UIButton!
  @IBOutlet private weak var viewCityPicker: UIPickerView!
	
	private var city = City.empty
	private var cities: [City] = []
	
	private lazy var storyBorad = {
		SwinjectStoryboard.create(name: "Main", bundle: nil, container: self.container ?? Container())
	}()
	
	override func attach() {
		super.attach()
		viewButtonContinue.isEnabled = city != City.empty
		// do the action in here
		disposeBag += viewButtonContinue.rx.tap
			.subscribe(onNext: startMainController(_ :))
		
		checkIfInitialLoadNeeded()
	}
	
	override func render(model: StartUpModel) {
		if model.state is Idle {
			if !model.data.isEmpty {
				// grab reference
				cities = model.data
				
				let dataSource = Observable.of(model.data)
				
				disposeBag += dataSource.bind(to: viewCityPicker.rx.itemTitles) { _, city -> String in
					return "\(city.name)"
				}
				
				disposeBag += viewCityPicker.rx.modelSelected(City.self)
					.map { UpdateSelectedCityEvent(city: $0.first ?? City.empty) }
					.subscribe(onNext: accept(_ :))
				
				if city == City.empty {
					// trigger first city selection
					accept(UpdateSelectedCityEvent(city: model.data.first ?? City.empty))
				}
			}
		} else if let state = model.state as? Operation {
			if state == selectCity {
				let selected = model.data.first ?? City.empty
				if city != selected {
					city = selected
					// update picker
					let position = cities.firstIndex { c in c.id == city.id } ?? -1
					if position != -1 {
						viewCityPicker.selectRow(position, inComponent: 0, animated: true)
					}
					// update background image
					viewImageBackground.image = UIImage(named: city.name.lowercased())
					// update title
					viewButtonSelectedCity.setTitle(city.name, for: .normal)
					// update button state
					viewButtonContinue.isEnabled = city != City.empty
				}
			}
		}
	}
	
	private func checkIfInitialLoadNeeded() {
		if cities.isEmpty {
			accept(LoadStartUpEvent())
		}
	}
	
	private func startMainController(_ event: Any) {
		let mainController = storyBorad.instantiateViewController(withIdentifier: "rootViewController")
		makeKeysAndVisible(controller: mainController)
	}
}
