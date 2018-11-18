//
//  Module.swift
//  Weather
//
//  Created by Fatih Şen on 18.11.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import MVICocoa
import Swinject
import SwinjectStoryboard

class Module {
	
	lazy var container = {
		Container()
	}()
	
	init() {
		// File Repository injection
		container.register(FileRepository.self) { _ in
			return FileRepositoryImp()
		}.inObjectScope(.container)
		
		// Connectivity Repository injection
		container.register(ConnectityRepository.self) { _ in
			return ConnectityRepositoryImp()
	  }.inObjectScope(.container)
		
		// User Defaults Repository injection
		container.register(UserDefaultsRepository.self) { resolver in
			if let fileRepository = resolver.resolve(FileRepository.self) {
				return UserDefaultsRepositoryImp(fileRepository: fileRepository)
			}
			fatalError("we can not resolve \(FileRepository.self)")
		}.inObjectScope(.container)
		
		// Weather Service injection
		container.register(WeatherService.self) { resolver in
			if let userDefaultsRepository = resolver.resolve(UserDefaultsRepository.self) {
				return WeatherServiceImp(userDefaultsRepository: userDefaultsRepository)
			}
			fatalError("we can not resolve \(UserDefaultsRepository.self)")
		}.inObjectScope(.container)
	
		// City Repository injection
		container.register(CityRepository.self) { resolver in
			if let fileRepository = resolver.resolve(FileRepository.self) {
				if let userDefaultsRepository = resolver.resolve(UserDefaultsRepository.self) {
					return CityRepositoryImp(fileRepository: fileRepository, userDefaultsRepository: userDefaultsRepository)
				}
				fatalError("we can not resolve \(UserDefaultsRepository.self)")
			}
			fatalError("we can not resolve \(FileRepository.self)")
		}.inObjectScope(.container)
		
		// Today Forecast Repository injection
		container.register(TodayForecastRepository.self) { resolver in
			if let fileRepository = resolver.resolve(FileRepository.self) {
				if let weatherService = resolver.resolve(WeatherService.self) {
					return TodayForecastRepositoryImp(fileRepository: fileRepository, weatherService: weatherService)
				}
				fatalError("we can not resolve \(WeatherService.self)")
			}
			fatalError("we can not resolve \(FileRepository.self)")
		}.inObjectScope(.container)
		
		// Daily Forecast Repository injection
		container.register(DailyForecastRepository.self) { resolver in
			if let fileRepository = resolver.resolve(FileRepository.self) {
				if let weatherService = resolver.resolve(WeatherService.self) {
					return DailyForecastRepositoryImp(fileRepository: fileRepository, weatherService: weatherService)
				}
				fatalError("we can not resolve \(WeatherService.self)")
			}
			fatalError("we can not resolve \(FileRepository.self)")
		}.inObjectScope(.container)
		
		// Start Up Controller injection
		container.storyboardInitCompleted(StartUpController.self) { _, controller in
			controller.viewModel = StartUpViewModel(view: controller)
		}
		
		// Main Controller injection
		container.storyboardInitCompleted(MainController.self) { _, controller in
			controller.viewModel = MainViewModel(view: controller)
		}
		// Today Forecast Controller injection
		container.storyboardInitCompleted(TodayForecastController.self) { resolver, controller in
			controller.viewModel = TodayForecastViewModel(view: controller)
			controller.userDefaultsRepository = resolver.resolve(UserDefaultsRepository.self)
		}
		
		// Daily Forecast Controller injection
		container.storyboardInitCompleted(DailyForecastController.self) { _, controller in
			controller.viewModel = DailyForecastViewModel(view: controller)
		}
		
		// Setting Controller injection
		container.storyboardInitCompleted(SettingController.self) { _, controller in
			controller.viewModel = SettingViewModel(view: controller)
		}
	}
}
