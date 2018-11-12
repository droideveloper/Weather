//
//  TodayForecastController.swift
//  Weather
//
//  Created by Fatih Şen on 13.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Swinject
import MVICocoa

class TodayForecastController: BaseViewController<TodayForecastModel, TodayForecastViewModel> {
	
  @IBOutlet public weak var progress: UIActivityIndicatorView!
  
  @IBOutlet private weak var viewImageBackground: UIImageView! // bg image for selected city
  @IBOutlet private weak var viewCityName: UILabel! // city name
  @IBOutlet private weak var viewTodayForecast: UILabel! // weather description
  @IBOutlet private weak var viewTodayWeather: UILabel! // tempereture of today
  @IBOutlet private weak var viewImageTodayWeather: UIImageView! // temperature of today icon
  
  @IBOutlet private weak var viewWind: UILabel! // wind speed
  @IBOutlet private weak var viewHumidity: UILabel! // humidity
  @IBOutlet private weak var viewSunrise: UILabel! // sunrise
  @IBOutlet private weak var viewDrops: UILabel! // rain
  @IBOutlet private weak var viewDirections: UILabel! // direction of wind
  @IBOutlet private weak var viewPressure: UILabel! // pressure of
	
  // will held ref for our change or not
  private var selectedtUnitLength: UnitOfLength = .metric
  private var selectedUnitTempereture: UnitOfTemperature = .celsius
  
  private var userDefaultsRepository: UserDefaultsRepository? = nil
  // city is nil
  private var city = City.empty
  private var todayForecast = TodayForecast.empty
	
	override func attach() {
		super.attach()
		checkIfMeasumentChanged() // check if measurement changed
		
		guard let viewModel = viewModel else { return }
		
		// bind animating state from coming model state
		disposeBag += viewModel.state()
			.map {
				if let state = $0 as? Operation {
					return state == refresh
				}
				return false
			}
			.do(onNext: invaldiateProgress(_ :))
			.subscribe(progress.rx.isAnimating)
		
		// bind background image in here
		disposeBag += viewModel.store()
			.map { model in model.city }
			.filter { self.city != $0 }
			.do(onNext: { city in self.city = city })
			.map { city in UIImage(named: city.name.lowercased()) }
			.subscribe(viewImageBackground.rx.image)
		
		// bind model
		disposeBag += viewModel.store()
			.subscribe(onNext: render(model:))
		
		// check if initial load is needed
		checkIfInitialLoadNeeded()
	}
	
	override func render(model: TodayForecastModel) {
		if model.state is Idle {
			render(todayForecast: model.data)
		} else if model.state is Operation {
		} else if model.state is Failure {
      if let failure = model.state as? Failure {
        showError(failure.error)
      }
		}
	}
  
  private func checkIfInitialLoadNeeded() {
    if city == City.empty {
      accept(LoadCityEvent())
    }
    if todayForecast == TodayForecast.empty {
      accept(LoadTodayForecastEvent())
    }
  }

  private func render(todayForecast: TodayForecast) {
    self.todayForecast = todayForecast
    // bind city name
    viewCityName.text = todayForecast.toCityName()
    // bind definition of weather
    viewTodayForecast.text = todayForecast.weathers.first?.toDescription() ?? "N/A"
    // bind user selections
    if let userDefaultsRepository = userDefaultsRepository {
      // bind tempreature
      let unitOfTempereture = UnitOfTemperature(rawValue: userDefaultsRepository.selectedUnitOfTemperature) ?? .celsius
      viewTodayWeather.text = todayForecast.toDegreeString(unit: unitOfTempereture)
      // bind wind
      let unitOfLength = UnitOfLength(rawValue: userDefaultsRepository.selectedUnitOfLength) ?? .metric
      viewWind.text = todayForecast.toLengthString(unit: unitOfLength)
    }
    if let url = URL(string: todayForecast.weathers.first?.toIconUrl() ?? "N/A") {
      // bind today icon
      viewImageTodayWeather.af_setImage(withURL: url)
    }
    // bind humidity
    viewHumidity.text = todayForecast.toHumidty()
    // bind cardinals
    viewDirections.text = todayForecast.toCardinals()
    // bind sunrise
    viewSunrise.text = todayForecast.sys.toSunrise()
    // bind pressure
    viewPressure.text = todayForecast.toPressure()
    // bind drops
    viewDrops.text = todayForecast.toRain()
  }

  private func checkIfMeasumentChanged() {
    if let userDefaultsRepository = userDefaultsRepository {
      let newUnitLength = UnitOfLength(rawValue: userDefaultsRepository.selectedUnitOfLength) ?? .metric
      let newUnitTempereture = UnitOfTemperature(rawValue: userDefaultsRepository.selectedUnitOfTemperature) ?? .celsius
      if newUnitLength != selectedtUnitLength {
        selectedtUnitLength = newUnitLength
        // render again
        if todayForecast != TodayForecast.empty {
          render(todayForecast: todayForecast)
        }
      }
      if newUnitTempereture != selectedUnitTempereture {
        selectedUnitTempereture = newUnitTempereture
        // render again
        if todayForecast != TodayForecast.empty {
          render(todayForecast: todayForecast)
        }
      }
    }
  }

	private func invaldiateProgress(_ visible: Bool) {
		progress.alpha = visible ? 1 : 0
	}
}
