//
//  PropertyChangable.swift
//  Weather
//
//  Created by Fatih Şen on 14.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

public protocol PropertyChangable: class {
	
	func notifyItemsRemoved(_ index: Int, size: Int)
	func notifyItemsInserted(_ index: Int, size: Int)
	func notifyItemsChanged(_ index: Int, size: Int)
}
