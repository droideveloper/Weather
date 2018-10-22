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
import RxSwift
import AlamofireImage

class DailyForecastCell: TableViewCell<DailyForecast> {
  
  @IBOutlet weak var viewImageDailyForecast: UIImageView!
  @IBOutlet weak var viewTextTitleDailyForecast: UILabel!
  @IBOutlet weak var viewTextTemperetureDailyForecast: UILabel!
  
  var userDefaultsRepository: UserDefaultsRepository? = nil
  
  private let disposeBag = DisposeBag()
  
  private lazy var dateFormatter: DateFormatter = {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "EEEE"
    return dateFormat
  }()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.selectionStyle = .none // disable selection here
  }

	override func bind(entity: DailyForecast) {
    if let weather = entity.weathers.first {
      // capitelize text
      let text = weather.toDescription()
      // will parse date
      let date = Date(timeIntervalSince1970: TimeInterval(entity.timestamp))
      // fotmat all together
      let string = "\(text) on \(dateFormatter.string(from: date))"
      // an set the text
      self.viewTextTitleDailyForecast.text = string
      // image url will be loaded in here
      if let uri = URL(string: weather.toIconUrl()) { // will convert weather icon from icon id
        self.viewImageDailyForecast.af_setImage(withURL: uri)
      }
    }
    bindTemperature(entity.tempereture) // bind temperature like this
    // bus manager will listen changes in here
    disposeBag += BusManager.register { [weak weakSelf = self] event in
      if event is UnitOfTemperatureChangedEvent {
        weakSelf?.bindTemperature(entity.tempereture)
      }
    }
	}
	
  override func unbind() { /*no opt*/ }
  
  private func bindTemperature(_ temperature: Tempereture) {
    if let userDefaultsRepository = userDefaultsRepository {
      if let unit = UnitOfTemperature(rawValue: userDefaultsRepository.selectedUnitOfTemperature) {
        self.viewTextTemperetureDailyForecast.text = temperature.toDegreeString(unit: unit)
      }
    }
  }
}
