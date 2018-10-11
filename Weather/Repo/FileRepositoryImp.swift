//
//  FileRepositoryImp.swift
//  Weather
//
//  Created by VNGRS on 11.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

class FileRepositoryImp: FileRepository {
    
    private let fileManager: FileManager
    
    private let KEY_CITY_FILE = "cities.json"
    private let KEY_DAILY_FORECAST_FILE = "daily_forecast.json"
    private let KEY_TODAY_FORECAST_FILE = "today_forecast.json"
    
    private let directory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, false).first
    
    var cityUrl: URL? {
        get {
            if let directory = directory {
                if let uri = URL(string: directory) {
                    return checkIfExistsAndCreate(url: uri.appendingPathComponent(KEY_CITY_FILE))
                }
            }
            return nil
        }
    }
    
    var dailyForecastUrl: URL? {
        get {
            if let directory = directory {
                if let uri = URL(string: directory) {
                    return checkIfExistsAndCreate(url: uri.appendingPathComponent(KEY_DAILY_FORECAST_FILE))
                }
            }
            return nil
        }
    }
    
    var todayForecastUrl: URL? {
        get {
            if let directory = directory {
                if let uri = URL(string: directory) {
                    return checkIfExistsAndCreate(url: uri.appendingPathComponent(KEY_TODAY_FORECAST_FILE))
                }
            }
            return nil
        }
    }
    
    init(fileManager: FileManager) {
        self.fileManager = fileManager
    }
    
    private func checkIfExistsAndCreate(url: URL) -> URL {
        if fileManager.fileExists(atPath: url.path) {
            return url
        } else {
            fileManager.createFile(atPath: url.path, contents: nil, attributes: nil)
            return url
        }
    }
    
}
