//
//  AppDelegate.swift
//  Weather
//
//  Created by Fatih Şen on 9.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard
import MVICocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, Injectable {
	
	var window: UIWindow?
	
	lazy var container = {
		Module().container
	}()
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		let storyBoard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: container)
		
		let window = UIWindow(frame: UIScreen.main.bounds)
		
		// TODO is this better of make root UINavigationController and then push content depending on conceptual choice
		// not sure what is the best practice in ios
		if let userDefaultsRepository = container.resolve(UserDefaultsRepository.self) {
			if userDefaultsRepository.selectedCityId != 0 {
				window.rootViewController = storyBoard.instantiateViewController(withIdentifier: "rootViewController")
			} else {
				window.rootViewController = storyBoard.instantiateViewController(withIdentifier: "startUpController")
			}
		} else {
			window.rootViewController = storyBoard.instantiateViewController(withIdentifier: "startUpController")
		}
		
		self.window = window
		window.makeKeyAndVisible()
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

