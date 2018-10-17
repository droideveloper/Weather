//
//  Tempereture.swift
//  Weather
//
//  Created by Fatih Şen on 17.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

struct Tempereture: Codable {
  
  static let empty = Tempereture(day: Double.nan, min: Double.nan, max: Double.nan, night: Double.nan, eve: Double.nan, morning: Double.nan)
  
  var day: Double
  var min: Double
  var max: Double
  var night: Double
  var eve: Double
  var morning: Double
  
  enum CodingKeys: String, CodingKey {
    case day, min, max, night, eve
    case morning = "morn"
  }
}
