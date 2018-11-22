//
//  Coordinate.swift
//  Weather
//
//  Created by Fatih Şen on 9.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation

public struct Coordinate: Codable, Equatable {
	
	public static let empty = Coordinate(longittude: Double.nan, lattitude: Double.nan)
	
	public var longittude: Double
	public var lattitude: Double
	
	public enum CodingKeys: String, CodingKey {
		case longittude = "lon"
		case lattitude = "lat"
	}
  
  public static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
    return lhs.lattitude == rhs.lattitude
  }
}
