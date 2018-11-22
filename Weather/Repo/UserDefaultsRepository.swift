//
//  UserDefaultsRepository.swift
//  Weather
//
//  Created by Fatih Şen on 9.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation

protocol UserDefaultsRepository {
	var selectedCityId: Int { get set }
	var selectedUnitOfLength: Int { get set }
	var selectedUnitOfTemperature: Int { get set }
	var shouldReadFromLocalRepository: Bool { get }
}
