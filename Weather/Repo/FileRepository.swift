//
//  FileRepository.swift
//  Weather
//
//  Created by VNGRS on 11.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift

protocol FileRepository {
	var cityUrl: URL? { get }
	var todayForecastUrl: URL? { get }
	var dailyForecastUrl: URL? { get }
	
	func clear(url: URL) -> Completable
	func write<T: Codable>(url: URL, object: T) -> Completable
	func read<T: Codable>(url: URL, as type: T.Type) -> Single<T>
}
