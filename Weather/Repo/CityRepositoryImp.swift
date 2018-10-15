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
	private let FILE_MIME = "json"
	
	private let fileRepository: FileRepository
	private let userDefaultsRepository: UserDefaultsRepository
	private let decoder = JSONDecoder()
	
	init(fileRepository: FileRepository, userDefaultsRepository: UserDefaultsRepository) {
		self.fileRepository = fileRepository
		self.userDefaultsRepository = userDefaultsRepository
	}
	
	func loadCities() -> Observable<[City]> {
		if userDefaultsRepository.shouldReadFromLocalRepository {
			return readSource()
				.flatMap { [weak weakSelf = self] cities -> Observable<[City]> in
					if let fileRepository = weakSelf?.fileRepository {
						if let url = fileRepository.cityUrl {
							return fileRepository.write(url: url, object: cities)
								.andThen(Observable.just(cities))
						}
					}
					return Observable.just(cities)
				}.do(onNext: { [weak weakSelf = self] _ -> Void in
					if var userDefaultsRepository = weakSelf?.userDefaultsRepository {
						userDefaultsRepository.shouldReadFromLocalRepository = false
					}
				})
		} else {
			if let cityStoredUrl = fileRepository.cityUrl {
				return fileRepository.read(url: cityStoredUrl, as: [City].self)
			}
			return Observable.never()
		}
	}
	
	fileprivate func readSource() -> Observable<[City]> {
		return Observable.create { [weak weakSelf = self] emitter in
			if let decoder = weakSelf?.decoder, let fileName = weakSelf?.FILE_NAME, let fileMime = weakSelf?.FILE_MIME {
				if let path = Bundle.main.path(forResource: fileName, ofType: fileMime) {
					do {
						let data = try Data(contentsOf: URL(fileURLWithPath: path))
						let result = try decoder.decode([City].self, from: data)
						emitter.onNext(result)
						emitter.onCompleted()
					} catch {
						emitter.onError(error)
					}
				}
			}
			return Disposables.create()
		}
	}

}
