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
  
  override func draw(_ rect: CGRect) {
    let path = UIBezierPath(ovalIn: self.bounds)
    UIColor.parse(0x999999).setFill()
    path.fill()
  }
}
