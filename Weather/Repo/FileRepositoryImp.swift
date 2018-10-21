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
	
	private let keyCityFile = "cities.json"
	private let keyDailyForecastFile = "daily_forecast.json"
	private let keyTodayForecastFile = "today_forecast.json"
	
	private let directory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, false).first
	
	var cityUrl: URL? {
		get {
			if let directory = directory {
				if let uri = URL(string: directory) {
					return uri.appendingPathComponent(keyCityFile)
				}
			}
			return nil
		}
	}
	
	var dailyForecastUrl: URL? {
		get {
			if let directory = directory {
				if let uri = URL(string: directory) {
					return uri.appendingPathComponent(keyDailyForecastFile)
				}
			}
			return nil
		}
	}
	
	var todayForecastUrl: URL? {
		get {
			if let directory = directory {
				if let uri = URL(string: directory) {
					return uri.appendingPathComponent(keyTodayForecastFile)
				}
			}
			return nil
		}
	}
	
	init(fileManager: FileManager) {
		self.fileManager = fileManager
	}
	
	func read<T>(url: URL, as type: T.Type) -> Observable<T> where T: Decodable, T: Encodable {
		return Observable.create { [weak weakSelf = self] emitter in
			if let fileManager = weakSelf?.fileManager, let decoder = weakSelf?.decoder {
				do {
					if fileManager.fileExists(atPath: url.path) {
						if let data = fileManager.contents(atPath: url.path) {
							let result = try decoder.decode(type, from: data)
							emitter.onNext(result)
							emitter.onCompleted()
						}
					} else {
						let error = NSError(domain: "no such file \(url.path)", code: 401, userInfo: nil)
						emitter.onError(error)
					}
				} catch {
					emitter.onError(error)
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
}
