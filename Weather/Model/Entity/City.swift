//
//  City.swift
//  Weather
//
//  Created by VNGRS on 9.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

struct City: Codable {
	var id: Int64
	var name: String
	var coordinate: Coordinate
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case coordinate = "coord"
	}
}
