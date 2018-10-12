//
//  Intent.swift
//  Weather
//
//  Created by Fatih Şen on 12.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift

public protocol Intent {}
open class ReducerIntent: Intent {
	
	func invoke<Model>() -> Reducer<Model> {
		return { model in return model }
	}
}

open class ObservableIntent: Intent {
	
	func invoke<Model>() -> Observable<Reducer<Model>> {
		return Observable.just({ model in return model })
	}
}

public typealias Reducer<T> = (T) -> T
