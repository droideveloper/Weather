//
//  Wind.swift
//  Weather
//
//  Created by VNGRS on 9.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

struct Wind: Codable, Equatable {
	
	static let empty = Wind(speed: Double.nan, degree: Double.nan)
	
	var speed: Double
	var degree: Double
	
	enum CodingKeys: String, CodingKey {
		case speed
		case degree = "deg"
	}
  
  static func == (lhs: Wind, rhs: Wind) -> Bool {
    return lhs.degree == rhs.degree
  }
}
