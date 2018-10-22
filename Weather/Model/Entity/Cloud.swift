//
//  Cloud.swift
//  Weather
//
//  Created by VNGRS on 9.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

struct Cloud: Codable, Equatable {
	static let empty = Cloud(all: Double.nan)
	
	var all: Double
  
  static func == (lhs: Cloud, rhs: Cloud) -> Bool {
    return lhs.all == rhs.all
  }
}
