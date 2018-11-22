//
//  City.swift
//  Weather
//
//  Created by Fatih Şen on 9.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation

public struct City: Codable, Equatable {
  
  public static let empty = City(id: Int64.min, name: String.empty, coordinate: Coordinate.empty)
  
	public var id: Int64
	public var name: String
	public var coordinate: Coordinate
	
	public enum CodingKeys: String, CodingKey {
		case id
		case name
		case coordinate = "coord"
	}
  
  public static func == (lhs: City, rhs: City) -> Bool {
    return lhs.id == rhs.id
  }
}
