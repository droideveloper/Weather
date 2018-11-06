//
//  DailyForecastCell.swift
//  Weather
//
//  Created by Fatih Şen on 15.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import UIKit
import MVICocoa
import AlamofireImage

class DailyForecastCell: UITableViewCell {
  
  @IBOutlet weak var viewImageDailyForecast: UIImageView!
  @IBOutlet weak var viewTextTitleDailyForecast: UILabel!
  @IBOutlet weak var viewTextTemperetureDailyForecast: UILabel!
	
	private let keySelectedUnitOfTemperature = "key.selected.unit.of.temperature"
	private let userDefaults = UserDefaults.standard
	
  private lazy var dateFormatter: DateFormatter = {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "EEEE"
    return dateFormat
  }()
	
	private let disposeBag = CompositeDisposeBag()
	
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.selectionStyle = .none // disable selection here
  }
	
	override func prepareForReuse() {
		super.prepareForReuse()
		disposeBag.clear()
	}

	func bind(entity: DailyForecast) {
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
	  
  private func bindTemperature(_ temperature: Tempereture) {
		if let unit = UnitOfTemperature(rawValue: userDefaults.integer(forKey: keySelectedUnitOfTemperature)) {
			self.viewTextTemperetureDailyForecast.text = temperature.toDegreeString(unit: unit)
		}
  }
}
