//
//  RoundedBackgroundView.swift
//  Weather
//
//  Created by Fatih Şen on 22.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

class RoundedBackgroundView: UIView {
  
  override func draw(_ rect: CGRect) {
    let path = UIBezierPath(roundedRect: rect, cornerRadius: 6)
    UIColor.white.setFill()
    path.fill()
  }
}
