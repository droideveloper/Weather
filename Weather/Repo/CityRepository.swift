//
//  CityRepository.swift
//  Weather
//
//  Created by Fatih Şen on 11.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import RxSwift

protocol CityRepository {
	func loadCities() -> Observable<[City]>
}
