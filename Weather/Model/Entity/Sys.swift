//
//  Sys.swift
//  Weather
//
//  Created by VNGRS on 9.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

struct Sys: Codable, Equatable {
	static let empty = Sys(type: Int.min, id: Int64.min, message: Double.nan, country: String.empty, sunrise: Int64.min, sunset: Int64.min)
	
	var type: Int
	var id: Int64
	var message: Double
	var country: String
	var sunrise: Int64
	var sunset: Int64
  
  static func == (lhs: Sys, rhs: Sys) -> Bool {
    return lhs.id == rhs.id
  }
}
