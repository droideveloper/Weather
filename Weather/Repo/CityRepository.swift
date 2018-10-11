//
//  CityRepository.swift
//  Weather
//
//  Created by Fatih Şen on 11.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift

protocol CityRepository {
	func loadCities() -> Single<[City]>
}
