//
//  View.swift
//  Weather
//
//  Created by Fatih Şen on 13.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import Swinject
import RxSwift

public protocol View {
	associatedtype Model
	
	var container: Container? { get }
	
	func render(model: Model)
	func viewEvents() -> Observable<Event>
}
