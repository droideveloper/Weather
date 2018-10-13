//
//  ViewModel.swift
//  Weather
//
//  Created by Fatih Şen on 13.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift

public protocol ViewModel {
	associatedtype Model
	
	func attach()
	func state() -> Observable<SyncState>
	func store() -> Observable<Model>
	func accept(intent: Intent)
}
