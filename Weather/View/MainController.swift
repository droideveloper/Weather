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
import MVICocoa
import Swinject
import SwinjectStoryboard

class MainController: UIViewController {
	
  @IBOutlet private weak var viewTodayForecastButton: UIButton!
	@IBOutlet private weak var viewTodayForecastTabItemView: TabItemView!
	
  @IBOutlet private weak var viewDailyForecastButton: UIButton!
	@IBOutlet private weak var viewDailyForecastTabItemView: TabItemView!
	
	private lazy var storyBoard = {
		SwinjectStoryboard.create(name: "Main", bundle: nil, container: self.container ?? Container())
	}()
	
	private var todayForecastController: TodayForecastController? = nil
	private var dailyForecastController: DailyForecastController? = nil
	
	private let disposeBag = CompositeDisposeBag()
  
	
	override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.setNavigationBarHidden(false, animated: false)
    self.navigationItem.setHidesBackButton(true, animated: false)
		super.viewWillAppear(animated)
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
    	detached?.detachFromParentViewController()
		}
    attached?.attachTo(parentViewController: self)
  }
}
