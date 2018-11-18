//
//  MainViewModel.swift
//  Weather
//
//  Created by Fatih Şen on 18.11.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import MVICocoa
import RxSwift

class MainViewModel: BaseViewModel<MainModel> {
  
  private weak var view: MainController?

  init(view: MainController) {
    self.view = view
  }

  override func attach() {
    super.attach()
    // if no view ignore
    guard let view = view else { return }
    // convert view events into relative intent and pass them pipeline
    disposeBag += view.viewEvents()
      .toIntent(view.container)
      .subscribe(onNext: accept(_ :))
  }
}