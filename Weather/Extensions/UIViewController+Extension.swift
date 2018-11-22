//
//  UIViewController+Extension.swift
//  Weather
//
//  Created by Fatih Şen on 18.11.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import UIKit
import Swinject
import SwinjectStoryboard

extension UIViewController {
	
	public func makeKeysAndVisible(controller: UIViewController) {
		if let delegate = UIApplication.shared.delegate as? AppDelegate {
			delegate.window?.rootViewController = controller
		}
	}
}

