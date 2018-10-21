//
//  TabItemView.swift
//  Weather
//
//  Created by Fatih Şen on 21.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
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
