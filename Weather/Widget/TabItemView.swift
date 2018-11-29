//
//  TabItemView.swift
//  Weather
//
//  Created by Fatih Şen on 21.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import UIKit

class TabItemView: UIView {
	
	var isSelected: Bool = false {
		didSet {
			subviews.forEach { view in
				if let view = view as? TabImageView {
					view.isSelected = isSelected
				} else if let view = view as? TabLabel {
					view.isSelected = isSelected
				}
			}
		}
	}
}
