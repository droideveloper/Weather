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
    func writeObject<T: Codable>(url: URL, object: T) -> Completable
    func writeArray<T: Codable>(url: URL, array: [T]) -> Completable
    func readObject<T: Codable>(url: URL) -> Single<T>
    func readArray<T: Codable>(url: URL) -> Single<[T]>
}
