//
//  TabLabel.swift
//  Weather
//
//  Created by Fatih Şen on 21.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class TabLabel: UILabel {
	
	var isSelected: Bool = false {
		didSet {
			if isSelected {
				textColor = UIColor.white
			} else {
				textColor = UIColor.lightGray
			}
		}
	}
}
