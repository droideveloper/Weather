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
    viewModel.view = self
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
  
  func viewEvents() -> Observable<Event> {
    return events.asObservable()
  }
}
