//
//  CityRepositoryImp.swift
//  Weather
//
//  Created by Fatih Şen on 11.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift
import MVICocoa

class CityRepositoryImp: CityRepository {
	
	private let fileName = "cities"
	private let fileMime = "json"
	
	private let keyCityFile = "cities.json"
	
	private let fileRepository: FileRepository
	private var userDefaultsRepository: UserDefaultsRepository
	private let decoder = JSONDecoder()
	
	init(fileRepository: FileRepository, userDefaultsRepository: UserDefaultsRepository) {
		self.fileRepository = fileRepository
		self.userDefaultsRepository = userDefaultsRepository
	}
	
	func loadCities() -> Observable<[City]> {
		if userDefaultsRepository.shouldReadFromLocalRepository {
			return readSource()
        .flatMap(persistIfNeeded(_ :))
		} else {
			if let url = fileRepository.file(for: keyCityFile) {
				return fileRepository.read(url: url, as: [City].self)
			}
			return Observable.never()
		}
  }
	
	fileprivate func persistIfNeeded(_ cities: [City]) -> Observable<[City]> {
		let url = fileRepository.file(for: keyCityFile)
		return Observable.of(fileRepository)
			.flatMap { fileRepository -> Observable<[City]> in
				if let url = url {
					return fileRepository.write(url: url, object: cities)
						.andThen(Observable.of(cities))
				}
				return Observable.of(cities)
			}
	}
	
	fileprivate func readSource() -> Observable<[City]> {
		if let path = Bundle.main.path(forResource: fileName, ofType: fileMime) {
			return Observable.of(path)
				.flatMap { path -> Observable<[City]> in
					do {
						let decoder = JSONDecoder()
						let data = try Data(contentsOf: URL(fileURLWithPath: path))
						let result = try decoder.decode([City].self, from: data)
						return Observable.of(result)
					} catch {
						return Observable.error(error)
					}
				}
		}
		return Observable.never()
	}
}
