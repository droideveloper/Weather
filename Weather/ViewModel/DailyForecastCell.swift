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
  
  private let borderColor = UIColor.parse(0x888888)
  private let borderTickness: CGFloat = 1
  
  override func setUp() {
    let bounds = self.contentView.frame
    // bg with 2 layers
    let layer = CAShapeLayer()
    layer.path = UIBezierPath(rect: bounds).cgPath
    layer.fillColor = borderColor.cgColor
    self.contentView.layer.addSublayer(layer)
    // white layer
    let wLayer = CAShapeLayer()
    let rect = CGRect(origin: CGPoint(x: 0, y: borderTickness), size: CGSize(width: bounds.width, height: bounds.height - 2 * borderTickness))
    wLayer.path = UIBezierPath(rect: rect).cgPath
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
