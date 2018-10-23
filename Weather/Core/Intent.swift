//
//  Intent.swift
//  Weather
//
//  Created by Fatih Şen on 13.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift

public protocol Intent {}

public class ObservableIntent<T>: Intent {
  func invoke() -> Observable<Reducer<T>> { return Observable.never() }
}

public typealias Reducer<T> = (T) -> T



