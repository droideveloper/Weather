//
//  ViewModelable.swift
//  Weather
//
//  Created by Fatih Şen on 12.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift

public protocol ViewModelable {
	associatedtype M
	
	func attah()
	func detach()
	func store() -> Observable<M>
	func accept(intent: Intent)
}
