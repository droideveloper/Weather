//
//  DailyForecastCell.swift
//  Weather
//
//  Created by Fatih Şen on 15.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

class DailyForecastCell: TableViewCell<DailyForecast> {
  
  override func setUp() {
    // bg with 2 layers
    let layer = CAShapeLayer()
    let bounds = self.contentView.frame
    layer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 0).cgPath
    layer.fillColor = UIColor.parse(0x888888).cgColor
    self.contentView.layer.addSublayer(layer)
    // white layer
    let wLayer = CAShapeLayer()
    let rect = CGRect(origin: CGPoint(x: 0, y: 1), size: CGSize(width: bounds.width, height: bounds.height - 2))
    wLayer.path = UIBezierPath(roundedRect: rect, cornerRadius: 0).cgPath
    wLayer.fillColor = UIColor.white.cgColor
    self.contentView.layer.addSublayer(wLayer)
  }
  
	override func bind(entity: DailyForecast) {
    // collect resources
	}
	
	override func unbind() {
		// collect resources
	}
}
