//
//  Coordinate.swift
//  Weather
//
//  Created by VNGRS on 9.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

struct Coordinate: Codable {
	
	static let empty = Coordinate(longittude: Double.nan, lattitude: Double.nan)
	
	var longittude: Double
	var lattitude: Double
	
	enum CodingKeys: String, CodingKey {
		case longittude = "lon"
		case lattitude = "lat"
	}
}
