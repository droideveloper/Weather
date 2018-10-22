//
//  File.swift
//  Weather
//
//  Created by Fatih Şen on 19.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import UIKit

class MainController: UIViewController {
	
  @IBOutlet private var viewTodayForecastTab: TabItemView!
  @IBOutlet private var viewDailyForecastTab: TabItemView!
  
  private let storyBoard = UIStoryboard(name: "Main", bundle: nil)
  private lazy var todayForecastController = {
    return storyBoard.instantiateViewController(withIdentifier: "todayForecastController") as! TodayForecastController
  }()
  private lazy var dailyForecastController = {
    return storyBoard.instantiateViewController(withIdentifier: "dailyForecastController") as! DailyForecastController
  }()
  
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationItem.leftBarButtonItem = nil // we do not want to show it
	}
	
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let todayForecastRecognizer = UIGestureRecognizer(target: self, action: #selector(self.viewTodayForecastSelected(_ :)))
    viewTodayForecastTab.addGestureRecognizer(todayForecastRecognizer)
    
    let dailyForecastRecognizer = UIGestureRecognizer(target: self, action: #selector(self.viewDailyForecastSelected(_:)))
    viewDailyForecastTab.addGestureRecognizer(dailyForecastRecognizer)
    
    checkIfInitialSelectionNeeded()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    // TODO
  }
  
  @objc func viewTodayForecastSelected(_ sender: UIGestureRecognizer?) {
    applyTabSelection(viewTodayForecastTab, viewDailyForecastTab)
    applyControllerSelection(todayForecastController, dailyForecastController)
  }
  
  @objc func viewDailyForecastSelected(_ sender: UIGestureRecognizer?) {
    applyTabSelection(viewDailyForecastTab, viewTodayForecastTab)
    applyControllerSelection(dailyForecastController, todayForecastController)
  }
  
  private func checkIfInitialSelectionNeeded()  {
    if !viewDailyForecastTab.isSelected && !viewDailyForecastTab.isSelected {
      viewTodayForecastSelected(nil) // initial selection
    }
  }
  
  private func applyTabSelection(_ selected: TabItemView, _ deSelected: TabItemView) {
    selected.isSelected = true
    deSelected.isSelected = false
  }
  
  private func applyControllerSelection(_ attached: UIViewController?, _ detached: UIViewController?) {
    detached?.detachParentViewController()
    attached?.attachParentViewController(viewController: self)
  }
}
