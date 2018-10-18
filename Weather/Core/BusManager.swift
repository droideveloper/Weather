//
//  BusManager.swift
//  Weather
//
//  Created by Fatih Şen on 17.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift

public class BusManager {
  
  private static let bus = PublishSubject<Event>()
  
  public static func send<T>(event: T) where T: Event {
    bus.onNext(event)
  }
  
  public static func register(_ block: @escaping (Event) -> Void) -> Disposable {
    return bus.subscribe(onNext: block)
  }
}
