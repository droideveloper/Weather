//
//  File.swift
//  Weather
//
//  Created by Fatih Şen on 19.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MainController: UIViewController {
	
  @IBOutlet private var viewTodayForecastButton: UIButton!
	@IBOutlet private var viewTodayForecastTabItemView: TabItemView!
	
  @IBOutlet private var viewDailyForecastButton: UIButton!
	@IBOutlet private var viewDailyForecastTabItemView: TabItemView!
	
  private let storyBoard = UIStoryboard(name: "Main", bundle: nil)
	private var todayForecastController: TodayForecastController? = nil
	private var dailyForecastController: DailyForecastController? = nil
	
	private let disposeBag = DisposeBag()
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationItem.leftBarButtonItem = nil // we do not want to show it
	}
	
  override func viewDidLoad() {
    super.viewDidLoad()
    
		disposeBag += viewDailyForecastButton.rx.tap
			.bind { [weak weakSelf = self] _ in
					weakSelf?.viewDailyForecastSelected()
			}
		
		disposeBag += viewTodayForecastButton.rx.tap
			.bind { [weak weakSelf = self] _ in
					weakSelf?.viewTodayForecastSelected()
			}

    checkIfInitialSelectionNeeded()
  }
  
	func viewTodayForecastSelected() {
		if !viewTodayForecastTabItemView.isSelected {
    	applyTabSelection(viewTodayForecastTabItemView, viewDailyForecastTabItemView)
			if todayForecastController == nil {
				todayForecastController = storyBoard.instantiateViewController(withIdentifier: "todayForecast") as? TodayForecastController
			}
    	applyControllerSelection(todayForecastController, dailyForecastController)
		}
  }
  
	func viewDailyForecastSelected() {
		if !viewDailyForecastTabItemView.isSelected {
			applyTabSelection(viewDailyForecastTabItemView, viewTodayForecastTabItemView)
			if dailyForecastController == nil {
				dailyForecastController = storyBoard.instantiateViewController(withIdentifier: "dailyForecast") as? DailyForecastController
			}
    	applyControllerSelection(dailyForecastController, todayForecastController)
		}
  }
  
  private func checkIfInitialSelectionNeeded()  {
    if !viewDailyForecastTabItemView.isSelected && !viewDailyForecastTabItemView.isSelected {
			viewTodayForecastSelected() // initial selection
    }
  }
  
  private func applyTabSelection(_ selected: TabItemView, _ deSelected: TabItemView) {
    selected.isSelected = true
    deSelected.isSelected = false
  }
  
  private func applyControllerSelection(_ attached: UIViewController?, _ detached: UIViewController?) {
		if detached?.view?.superview != nil {
    	detached?.detachParentViewController()
		}
    attached?.attachParentViewController(viewController: self)
  }
}
