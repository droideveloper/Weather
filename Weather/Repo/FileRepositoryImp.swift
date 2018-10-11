//
//  FileRepositoryImp.swift
//  Weather
//
//  Created by VNGRS on 11.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift

class FileRepositoryImp: FileRepository {
	
	private let fileManager: FileManager
	private let decoder = JSONDecoder()
	private let encoder = JSONEncoder()
	
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
	
	func clear(url: URL) -> Completable {
		return Completable.create { [weak weakSelf = self] emitter in
			if let fileManager = weakSelf?.fileManager {
				if fileManager.isDeletableFile(atPath: url.path) {
					do {
						try fileManager.removeItem(atPath: url.path)
						emitter(.completed)
					} catch  {
						emitter(.error(error))
					}
				}
			}
			return Disposables.create()
		}
	}
	
	func read<T>(url: URL, as type: T.Type) -> Single<T> where T: Decodable, T: Encodable {
		return Single.create { [weak weakSelf = self] emitter in
			if let fileManager = weakSelf?.fileManager, let decoder = weakSelf?.decoder {
				do {
					if fileManager.fileExists(atPath: url.path) {
						if let data = fileManager.contents(atPath: url.path) {
							let result = try decoder.decode(type, from: data)
							emitter(.success(result))
						}
					} else {
						let error = NSError(domain: "no such file \(url.path)", code: 401, userInfo: nil)
						emitter(.error(error))
					}
				} catch {
					emitter(.error(error))
				}
			}
			return Disposables.create()
		}
	}
	
	func write<T>(url: URL, object: T) -> Completable where T : Decodable, T : Encodable {
		return Completable.create { [weak weakSelf = self] emitter in
			if let fileManager = weakSelf?.fileManager, let encoder = weakSelf?.encoder {
				do {
					let data = try encoder.encode(object)
					if fileManager.fileExists(atPath: url.path) {
						try fileManager.removeItem(at: url)
					}
					fileManager.createFile(atPath: url.path, contents: data, attributes: nil)
					emitter(.completed)
				} catch {
					emitter(.error(error))
				}
			}
			return Disposables.create()
		}
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
