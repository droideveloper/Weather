//
//  Settingable.swift
//  Weather
//
//  Created by Fatih Şen on 23.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

public class Settingable: Equatable {
	
	public static let empty = Settingable()
	
	var title: String {
		get {
			return String.empty
		}
	}
	
	var value: String {
		get {
			return String.empty
		}
	}
	
	public static func == (lhs: Settingable, rhs: Settingable) -> Bool {
		return lhs.value == rhs.value && lhs.title == rhs.title
	}
}
