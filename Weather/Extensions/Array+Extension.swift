//
//  Array+Extension.swift
//  Weather
//
//  Created by Fatih Şen on 13.11.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

public extension Array where Element: Equatable {
	
	public func indexOf(block: (Element) -> Bool) -> Int {
		for i in 0..<count {
			if block(self[i]) {
				return i
			}
		}
		return -1
	}
}
