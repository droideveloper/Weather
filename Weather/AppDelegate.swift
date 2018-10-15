//
//  AppDelegate.swift
//  Weather
//
//  Created by VNGRS on 9.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
  var container: Container?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    self.container = Container()
    self.container?.register(UserDefaultsRepository.self, factory: { _ in UserDefaultsRepositoryImp() })
    self.container?.register(FileManager.self, factory: { _ in FileManager.default } )
    self.container?.register(FileRepository.self, factory: { resolver in
      let fileManager = resolver.resolve(FileManager.self)
      if let fileManager = fileManager {
        return FileRepositoryImp(fileManager: fileManager)
      }
      fatalError("can not resolve fileManager")
    })
    self.container?.register(CityRepository.self, factory: { resolver in
      let fileRepository = resolver.resolve(FileRepository.self)
      let userDefaultsRepository = resolver.resolve(UserDefaultsRepository.self)
      if let fileRepository = fileRepository, let userDefaultsRepository = userDefaultsRepository {
        return CityRepositoryImp(fileRepository: fileRepository, userDefaultsRepository: userDefaultsRepository)
      }
      fatalError("can not resolve fileRepository or userDefaultsRepository")
    })
    self.container?.register(WeatherService.self, factory: { resovler in
      let userDefaultsRepository = resovler.resolve(UserDefaultsRepository.self)
      if let userDefaultsRepository = userDefaultsRepository {
        return WeatherServiceImp(userDefaultsRepository: userDefaultsRepository)
      }
      fatalError("can not resolve userDefaultsRepository")
    })
    self.container?.register(TodayForecastRepository.self, factory: { resolver in
      let fileRepository = resolver.resolve(FileRepository.self)
      let weatherService = resolver.resolve(WeatherService.self)
      if let fileRepository = fileRepository, let weatherService = weatherService {
        return TodayForecastRepositoryImp(fileRepository: fileRepository, weatherService: weatherService)
      }
      fatalError("can not resolve fileRepository or weatherService")
    })
    self.container?.register(DailyForecastRepository.self, factory: { resolver in
      let fileRepository = resolver.resolve(FileRepository.self)
      let weatherService = resolver.resolve(WeatherService.self)
      if let fileRepository = fileRepository, let weatherService = weatherService {
        return DailyForecastRepositoryImp(fileRepository: fileRepository, weatherService: weatherService)
      }
      fatalError("can not resolve fileRepository or weatherService")
    })
		// Override point for customization after application launch.
		return true
	}
	
	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}
	
	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}
	
	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}
	
	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}
	
	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}
	
	
}

