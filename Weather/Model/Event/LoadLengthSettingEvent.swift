//
//  LoadLengthSettingEvent.swift
//  Weather
//
//  Created by Fatih Şen on 10.11.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import MVICocoa
import Swinject

class LoadLengthSettingEvent: Event {

  override func toIntent(container: Container?) -> Intent {
    // TODO provide relative dependency here
    return super.toIntent(container: container) // will provide nothing intent if there is no intent relative to this event 
  }
}
