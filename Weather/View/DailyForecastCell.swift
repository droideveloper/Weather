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
  
  @IBOutlet weak var viewImageDailyForecast: CircleBackgroundImageView!
  @IBOutlet weak var viewTextTitleDailyForecast: UILabel!
  @IBOutlet weak var viewTextTemperetureDailyForecast: UILabel!
  
  private let celciusFormat = "%d "
  
  private lazy var dateFormatter: DateFormatter = {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "EEEE"
    return dateFormat
  }()

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
      
      if let uri = URL(string: weather.icon.toWeatherIconUrl()) { // will convert weather icon from icon id
        self.viewImageDailyForecast.af_setImage(withURL: uri)
      }
    }
    // parse text for tempereture
    let temperetureString = String.init(format: celciusFormat, Int(entity.tempereture.day.kelvinToCelsius())) // only supporting celcius for now
    self.viewTextTemperetureDailyForecast.text = temperetureString
	}
	
  override func unbind() { /*no opt*/ }
}
