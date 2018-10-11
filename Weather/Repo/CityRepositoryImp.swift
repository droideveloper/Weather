//
//  CityRepositoryImp.swift
//  Weather
//
//  Created by Fatih Şen on 11.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift

class CityRepositoryImp: CityRepository {
	
	private let FILE_NAME = "cities"
	private let FILE_MIME = ".json"
	
	private let fileRepository: FileRepository
	private let userDefaultsRepository: UserDefaultsRepository
	private let decoder = JSONDecoder()
	
	init(fileRepository: FileRepository, userDefaultsRepository: UserDefaultsRepository) {
		self.fileRepository = fileRepository
		self.userDefaultsRepository = userDefaultsRepository
	}
	
	func loadCities() -> Single<[City]> {
		if userDefaultsRepository.shouldReadFromLocalRepository {
			return Single.create { [weak weakSelf = self] emitter in
				if let decoder = weakSelf?.decoder, let fileName = weakSelf?.FILE_NAME, let fileMime = weakSelf?.FILE_MIME {
					if let path = Bundle.main.path(forResource: fileName, ofType: fileMime) {
						do {
							let data = try Data(contentsOf: URL(fileURLWithPath: path))
							let result = try decoder.decode([City].self, from: data)
							emitter(.success(result))
						} catch {
							emitter(.error(error))
						}
					}
				}
				return Disposables.create()
			}.flatMap { [weak weakSelf = self] cities in
				return weakSelf?.persistOrReturnAlready(cities: cities) ?? Single.just(cities)
			}
		} else {
			if let cityStoredUrl = fileRepository.cityUrl {
				return fileRepository.read(url: cityStoredUrl, as: [City].self)
			}
			return Single.never()
		}
	}
	
	fileprivate func persistOrReturnAlready(cities: [City]) -> Single<[City]> {
		return Single.just(cities)
			.flatMap { [weak weakSelf = self] cities in
				if let fileRepository = weakSelf?.fileRepository {
					if let url = fileRepository.cityUrl {
						return fileRepository.write(url: url, object: cities)
							.andThen(Single.just(cities))
					}
				}
				return Single.just(cities)
			}.do(onSuccess: { [weak weakSelf = self] _ in
				if var userDefaultsRepository = weakSelf?.userDefaultsRepository {
					userDefaultsRepository.shouldReadFromLocalRepository = false
				}
			})
	}
}
