//
//  SettingCell.swift
//  Weather
//
//  Created by Fatih Şen on 23.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import UIKit

class SettingCell: TableViewCell<Settingable> {
	
	@IBOutlet private weak var viewTextTitle: UILabel!
	@IBOutlet private weak var viewTextSubtitle: UILabel!
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		selectionStyle = .none
	}
	
	override func bind(entity: Settingable) {
		viewTextTitle.text = entity.title
		viewTextSubtitle.text = entity.value
	}
}
