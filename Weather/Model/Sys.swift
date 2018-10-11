//
//  Sys.swift
//  Weather
//
//  Created by VNGRS on 9.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

struct Sys: Codable {
	var type: Int
	var id: Int64
	var message: Double
	var country: String
	var sunrise: Int64
	var sunset: Int64
}
