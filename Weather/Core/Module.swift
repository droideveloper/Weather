//
//  Module.swift
//  Weather
//
//  Created by Fatih Şen on 15.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import Swinject

public struct Module {
	
	let container: Container
	
	init() {
		self.container = Container()
		// user defaults
		self.container.register(UserDefaultsRepository.self, factory: { _ in UserDefaultsRepositoryImp() })
		// file manager
		self.container.register(FileManager.self, factory: { _ in FileManager.default } )
    // connectivity repository
    self.container.register(ConnectityRepository.self, factory: { _ in ConnectityRepositoryImp() })
		// file repository
		self.container.register(FileRepository.self, factory: { resolver in
			let fileManager = resolver.resolve(FileManager.self)
			if let fileManager = fileManager {
				return FileRepositoryImp(fileManager: fileManager)
			}
			fatalError("can not resolve fileManager")
		})
		// city repository
		self.container.register(CityRepository.self, factory: { resolver in
			let fileRepository = resolver.resolve(FileRepository.self)
			let userDefaultsRepository = resolver.resolve(UserDefaultsRepository.self)
			if let fileRepository = fileRepository, let userDefaultsRepository = userDefaultsRepository {
				return CityRepositoryImp(fileRepository: fileRepository, userDefaultsRepository: userDefaultsRepository)
			}
			fatalError("can not resolve fileRepository or userDefaultsRepository")
		})
		// weather service
		self.container.register(WeatherService.self, factory: { resovler in
			let userDefaultsRepository = resovler.resolve(UserDefaultsRepository.self)
			if let userDefaultsRepository = userDefaultsRepository {
				return WeatherServiceImp(userDefaultsRepository: userDefaultsRepository)
			}
			fatalError("can not resolve userDefaultsRepository")
		})
		// today forecast repository
		self.container.register(TodayForecastRepository.self, factory: { resolver in
			let fileRepository = resolver.resolve(FileRepository.self)
			let weatherService = resolver.resolve(WeatherService.self)
			if let fileRepository = fileRepository, let weatherService = weatherService {
				return TodayForecastRepositoryImp(fileRepository: fileRepository, weatherService: weatherService)
			}
			fatalError("can not resolve fileRepository or weatherService")
		})
		// daily forecast repository
		self.container.register(DailyForecastRepository.self, factory: { resolver in
			let fileRepository = resolver.resolve(FileRepository.self)
			let weatherService = resolver.resolve(WeatherService.self)
			if let fileRepository = fileRepository, let weatherService = weatherService {
				return DailyForecastRepositoryImp(fileRepository: fileRepository, weatherService: weatherService)
			}
			fatalError("can not resolve fileRepository or weatherService")
		})
    // data set
    self.container.register(ObservableList<DailyForecast>.self, factory: { _ in ObservableList<DailyForecast>() })
    // daily forecast data source
    self.container.register(DailyForecastDataSource.self, factory: { resolver in
      let dataSet = resolver.resolve(ObservableList<DailyForecast>.self)
      if let dataSet = dataSet {
        return DailyForecastDataSource(dataSet: dataSet)
      }
      fatalError("can not resolve dataSet")
    })
	}
}
