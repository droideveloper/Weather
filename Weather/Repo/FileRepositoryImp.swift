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
	
	private let keyCityFile = "cities.json"
	private let keyDailyForecastFile = "daily_forecast.json"
	private let keyTodayForecastFile = "today_forecast.json"
	
	private let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
	
	var cityUrl: URL? {
		get {
			if let directory = directory {
				return directory.appendingPathComponent(keyCityFile)
			}
			return nil
		}
	}
	
	var dailyForecastUrl: URL? {
		get {
			if let directory = directory {
				return directory.appendingPathComponent(keyDailyForecastFile)
			}
			return nil
		}
	}
	
	var todayForecastUrl: URL? {
		get {
			if let directory = directory {
				return directory.appendingPathComponent(keyTodayForecastFile)
			}
			return nil
		}
	}
	
	func read<T>(url: URL, as type: T.Type) -> Observable<T> where T: Decodable, T: Encodable {
		return Observable.create { emitter in
				do {
					let decoder = JSONDecoder()
					let fileManager = FileManager.default
					
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
			
			return Disposables.create()
		}
	}
	
	func write<T>(url: URL, object: T) -> Completable where T : Decodable, T : Encodable {
		return Completable.create { emitter in
				do {
					let encoder = JSONEncoder()
					let fileManager = FileManager.default
					
					let data = try encoder.encode(object)
					if fileManager.fileExists(atPath: url.path) {
						try fileManager.removeItem(at: url)
					}
					let success = fileManager.createFile(atPath: url.path, contents: data, attributes: nil)
					if success {
						emitter(.completed)
					} else {
						let error = NSError(domain: "you could not create file at \(url.path)", code: 404, userInfo: nil)
						emitter(.error(error))
					}
				} catch {
					emitter(.error(error))
				}
			return Disposables.create()
		}
	}
}
