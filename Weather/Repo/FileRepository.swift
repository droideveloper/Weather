//
//  FileRepository.swift
//  Weather
//
//  Created by VNGRS on 11.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

protocol FileRepository {
    var cityUrl: URL? { get }
    var todayForecastUrl: URL? { get }
    var dailyForecastUrl: URL? { get }
}
