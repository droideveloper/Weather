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

@IBDesignable
class BackgroundView: UIView {
 
  required init?(coder aDecoder: NSCoder) {
   super.init(coder: aDecoder)
   
   let rect = CGRect(x: 0, y: 1, width: self.bounds.width, height: self.bounds.height - 2)
   
   let darkLayer = CAShapeLayer()
   darkLayer.path = UIBezierPath(rect: self.bounds).cgPath
   darkLayer.fillColor = UIColor.darkGray.cgColor
   self.layer.addSublayer(darkLayer)
   
   let whiteLayer = CAShapeLayer()
   whiteLayer.path = UIBezierPath(rect: rect).cgPath
   whiteLayer.fillColor = UIColor.white.cgColor
   self.layer.addSublayer(whiteLayer)
  }
}
