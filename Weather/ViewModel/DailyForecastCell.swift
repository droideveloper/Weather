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
import AlamofireImage

class DailyForecastCell: TableViewCell<DailyForecast> {
  
  @IBOutlet weak var viewImageDailyForecast: UIImageView!
  @IBOutlet weak var viewTextTitleDailyForecast: UILabel!
  @IBOutlet weak var viewTextTemperetureDailyForecast: UILabel!
  
  private let celciusFormat = "%d \u{00b0c}"
  
  private lazy var dateFormatter: DateFormatter = {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "EEEE"
    return dateFormat
  }()
  
  private let imageBg = UIColor.parse(0x999999)
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
    
    let imageBgLayer = CAShapeLayer()
    imageBgLayer.path = UIBezierPath(ovalIn: self.viewImageDailyForecast.bounds).cgPath
    imageBgLayer.fillColor = imageBg.cgColor
    self.viewImageDailyForecast.layer.addSublayer(imageBgLayer)
  }
  
	override func bind(entity: DailyForecast) {
    if let weather = entity.weathers.first {
      // capitelize text
      let text = weather.description.capitalizeSentance()
      // will parse date
      let date = Date(timeIntervalSince1970: TimeInterval(entity.timestamp * 1000))
      // fotmat all together
      let string = "\(text) on \(dateFormatter.string(from: date))"
      // an set the text
      self.viewTextTitleDailyForecast.text = string
      
      let url = "http://i.openweather.org/\(weather.icon).png"
      if let uri = URL(string: url) {
        self.viewImageDailyForecast.af_setImage(withURL: uri)
      }
    }
    // parse text for tempereture
    let temperetureString = String.init(format: celciusFormat, Int(entity.main.temperature))
    self.viewTextTemperetureDailyForecast.text = temperetureString
	}
	
  override func unbind() { /*no opt*/ }
}
