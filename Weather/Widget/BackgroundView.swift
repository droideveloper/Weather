//
//  BackgroundView.swift
//  Weather
//
//  Created by Fatih Şen on 17.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

@IBDesignable
class BackgroundView: UIView {
 
 override func draw(_ rect: CGRect) {
  let path = UIBezierPath(ovalIn: rect)
  UIColor.lightGray.withAlphaComponent(0.8).setFill()
  path.fill()
 }
}
