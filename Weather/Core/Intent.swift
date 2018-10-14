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

public struct NothingIntent: Intent {}

public protocol ReducerIntent: Intent {
	associatedtype Model
	
	func invoke() -> Reducer<Model>
}

public protocol ObservableInent: Intent {
	associatedtype Model
	
	func invoke() -> Observable<Reducer<Model>>
}

public typealias Reducer<T> = (T) -> T

