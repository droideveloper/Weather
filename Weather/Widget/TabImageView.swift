//
//  TabImageView.swift
//  Weather
//
//  Created by Fatih Şen on 21.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class TabImageView: UIImageView {
	
	var isSelected: Bool = false {
		didSet {
			if let image = image?.withRenderingMode(.alwaysTemplate) {
				self.image = image
				if isSelected {
					tintColor = UIColor.white
				} else {
					tintColor = UIColor.lightGray
				}
			}
		}
	}
	
}
