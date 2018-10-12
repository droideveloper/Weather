//
//  Cloud.swift
//  Weather
//
//  Created by VNGRS on 9.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

struct Cloud: Codable {
	static let empty = Cloud(all: Double.nan)
	
	var all: Double
}
