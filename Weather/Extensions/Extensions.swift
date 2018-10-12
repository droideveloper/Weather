//
//  Extensions.swift
//  Weather
//
//  Created by VNGRS on 11.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift

extension Double {
	
	public func kelvinToCelsius() -> Double {
		return self - 273.15
	}
	
	public func kelvinToFahrenheit() -> Double {
		return kelvinToCelsius() * 1.8 + 32
	}
}

extension DisposeBag {
	
	static func += (disposeBag: DisposeBag, disposable: Disposable) {
		disposeBag.insert(disposable)
	}
}

extension Observable where Element: Event {

	func toIntent(_ block: @escaping (Element) -> Intent) -> Observable<Intent> {
		return self.map(block)
	}
}

extension Observable where Element: ReducerIntent {
	
	func toReducer<T>() -> Observable<Reducer<T>> where Element.Model == T {
		return self.map { intent in
			return intent.invoke()
		}
	}
}

extension Observable where Element: ObservableIntent {
	
	func toReducer<T>() -> Observable<Reducer<T>> where Element.Model == T {
		return self.flatMap { intent in
			return intent.invoke()
		}
	}
}

extension String {
	
	static let empty = ""
	
}
