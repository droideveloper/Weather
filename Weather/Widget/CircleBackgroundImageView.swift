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

class CircleBackgroundImageView: UIImageView {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    // update layer
    let layer = CAShapeLayer()
    let path = UIBezierPath(ovalIn: self.frame)
    layer.path = path.cgPath
    layer.fillColor = UIColor.parse(0x999999).cgColor
    self.layer.insertSublayer(layer, at: 0)
  }
}
