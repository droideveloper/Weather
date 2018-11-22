//
//  File.swift
//  Weather
//
//  Created by Fatih Şen on 19.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import MVICocoa
import Swinject
import SwinjectStoryboard

class MainController: BaseViewController<MainModel, MainViewModel> {
	
	@IBOutlet private weak var viewSettingsBarButton: UIBarButtonItem!
  @IBOutlet private weak var viewTodayForecastButton: UIButton!
	@IBOutlet private weak var viewTodayForecastTabItemView: TabItemView!
	
  @IBOutlet private weak var viewDailyForecastButton: UIButton!
	@IBOutlet private weak var viewDailyForecastTabItemView: TabItemView!
	
	private var tab = Tab.none
	
	private lazy var storyBoard = {
		SwinjectStoryboard.create(name: "Main", bundle: nil, container: self.container ?? Container())
	}()
	
	private var todayForecastController: TodayForecastController? = nil
	private var dailyForecastController: DailyForecastController? = nil
	
	override func setUp() {
		self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		self.navigationController?.navigationBar.shadowImage = UIImage()
	}
	
	override func attach() {
		super.attach()
		
		disposeBag += viewDailyForecastButton.rx.tap
			.map { SelectTabEvent(tab: .dailyForecast) }
			.subscribe(onNext: accept(_ :))
		
		disposeBag += viewTodayForecastButton.rx.tap
			.map { SelectTabEvent(tab: .todayForecast) }
			.subscribe(onNext: accept(_ :))
		
		disposeBag += viewSettingsBarButton.rx.tap
			.subscribe(onNext: pushSettings(_ :))
		
		checkIfInitialLoadNeeded()
	}
	
	override func render(model: MainModel) {
		if let state = model.state as? Operation {
			if state == selectTab {
				let selectedTab = model.data.first ?? .none
				if selectedTab != .none {
					tab = selectedTab
					let controller = controllerForTab(selectedTab)
					applyControllerSelection(controller, controller is TodayForecastController ? dailyForecastController: todayForecastController)
					let tabView = tabViewForTab(tab)
					applyTabSelection(tabView, tabView == viewTodayForecastTabItemView ? viewDailyForecastTabItemView: viewTodayForecastTabItemView)
				}
			}
		}
	}
	
	private func checkIfInitialLoadNeeded() {
		if tab == .none {
			accept(SelectTabEvent(tab: .todayForecast))
		}
	}
	
	private func controllerForTab(_ tab: Tab) -> UIViewController {
		if tab == .todayForecast {
			if todayForecastController == nil {
				todayForecastController = storyBoard.instantiateViewController(withIdentifier: "todayForecastController") as? TodayForecastController
			}
			guard let todayForecastController = todayForecastController else {
				fatalError("we can not initialize \(TodayForecastController.self)")
			}
			return todayForecastController
		} else if tab == .dailyForecast {
			if dailyForecastController == nil {
				dailyForecastController = storyBoard.instantiateViewController(withIdentifier: "dailyForecastController") as? DailyForecastController
			}
			guard let dailyForecastController = dailyForecastController else {
				fatalError("we can not initialize \(DailyForecastController.self)")
			}
			return dailyForecastController
		} else {
			fatalError("there is no controller for \(tab)")
		}
	}
	
	private func tabViewForTab(_ tab: Tab) -> TabItemView {
		if tab == .todayForecast {
			return viewTodayForecastTabItemView
		} else if tab == .dailyForecast {
			return viewDailyForecastTabItemView
		} else {
			fatalError("there is no tabItem for \(tab)")
		}
	}
	
  private func applyTabSelection(_ selected: TabItemView, _ deSelected: TabItemView) {
    selected.isSelected = true
    deSelected.isSelected = false
  }
  
  private func applyControllerSelection(_ attached: UIViewController?, _ detached: UIViewController?) {
		if detached?.view?.superview != nil {
    	detached?.detachFromParentViewController()
		}
    attached?.attachTo(parentViewController: self)
  }
	
	private func pushSettings(_ : Any) {
		let settingController = storyBoard.instantiateViewController(withIdentifier: "settingController")
		self.navigationController?.pushViewController(settingController, animated: true)
	}
}
