//
//  Weather.swift
//  Weather
//
//  Created by VNGRS on 9.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

struct Weather: Codable {
    var id: Int64
    var title: String
    var description: String
    var icon: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "main"
        case description
        case icon
    }
}
