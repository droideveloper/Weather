//
//  Rain.swift
//  Weather
//
//  Created by Fatih Şen on 22.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation

struct Rain: Codable, Equatable {
  
  static let empty = Rain(percentage: Double.nan)
  
  var percentage: Double
  
  enum CodingKeys: String, CodingKey {
    case percentage = "3h"
  }
  
  static func == (lhs: Rain, rhs: Rain) -> Bool {
    return lhs.percentage == rhs.percentage
  }
}
