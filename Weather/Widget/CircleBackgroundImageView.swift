//
//  CircleBackgroundImageView.swift
//  Weather
//
//  Created by Fatih Şen on 17.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

@IBDesignable
class CircleBackgroundImageView: UIImageView {
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    let path = UIBezierPath(ovalIn: self.frame)
    UIColor.parse(0x000000).setFill()
    path.fill()
  }
}
