//
//  BackgroundView.swift
//  Weather
//
//  Created by Fatih Şen on 17.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

class BackgroundView: UIView {
  
  override func draw(_ rect: CGRect) {
    let strokeSize: CGFloat = 1
    let secondRect = CGRect(x: 0, y: strokeSize, width: frame.size.width, height: frame.size.height - 2 * strokeSize)
    
    let firstPath = UIBezierPath(rect: frame)
    UIColor.white.setFill()
    firstPath.fill()
    
    let secondPath = UIBezierPath(rect: secondRect)
    UIColor.parse(0x888888).setFill()
    secondPath.fill()
  }
}
