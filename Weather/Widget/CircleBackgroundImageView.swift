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
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    let oval = CAShapeLayer()
    oval.path = UIBezierPath(ovalIn: self.bounds).cgPath
    oval.fillColor = UIColor.gray.withAlphaComponent(0.5).cgColor
    self.layer.addSublayer(oval)
  }
}
