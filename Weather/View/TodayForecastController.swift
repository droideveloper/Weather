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

class TodayForecastController: UIViewController, View {
	typealias Model = TodayForecastModel
	
	private let viewModel = TodayForecastViewModel()
	private let disposeBag = DisposeBag()
	private let events = PublishRelay<Event>()
		
  @IBOutlet private var viewProgress: UIActivityIndicatorView!
  
  @IBOutlet private var viewImageBackground: UIImageView! // bg image for selected city
  @IBOutlet private var viewCityName: UILabel! // city name
  @IBOutlet private var viewTodayForecast: UILabel! // weather description
  @IBOutlet private var viewTodayWeather: UILabel! // tempereture of today
  @IBOutlet private var viewImageTodayWeather: UIImageView! // temperature of today icon
  
  @IBOutlet private var viewWind: UILabel! // wind speed
  @IBOutlet private var viewHumidity: UILabel! // humidity
  @IBOutlet private var viewSunrise: UILabel! // sunrise
  @IBOutlet private var viewDrops: UILabel! // rain
  @IBOutlet private var viewDirections: UILabel! // direction of wind
  @IBOutlet private var viewPressure: UILabel! // pressure of 
	
  // will held ref for our change or not
  private var selectedtUnitLength: UnitOfLength = .metric
  private var selectedUnitTempereture: UnitOfTemperature = .celsius
  
  private var cityRepository: CityRepository? = nil
  private var userDefaultsRepository: UserDefaultsRepository? = nil
  // city is nil
  private var city = City.empty
  private var todayForecast = TodayForecast.empty
  
  override func viewWillAppear(_ animated: Bool) {
    checkIfMeasumentChanged()
    super.viewWillAppear(animated)
  }
  
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setUp()
		viewModel.attach()
    
    checkIfInitialLoadNeeded() // we will bind background image this way
	}
	
	func setUp() {
		viewModel.view = self
    // resolve
    cityRepository = container?.resolve(CityRepository.self)
    userDefaultsRepository = container?.resolve(UserDefaultsRepository.self)
    
    // bind animating state from coming model state
    disposeBag += viewModel.state()
      .map {
        if let state = $0 as? ProcessState {
          return state == refresh
        }
        return false
      }
      .do(onNext: { [weak weakSelf = self] visible in
        weakSelf?.viewProgress.alpha = visible ? 1 : 0
      })
      .subscribe(viewProgress.rx.isAnimating)
    
    disposeBag += viewModel.store()
      .subscribe(onNext: render(model:))
  }
	
	override func viewDidDisappear(_ animated: Bool) {
		viewModel.view = nil // remove view referance when this is detached
		super.viewDidDisappear(animated)
	}
	
	func render(model: TodayForecastModel) {
		if model.syncState is IdleState {
      render(todayForecast: model.data)
		} else if model.syncState is ProcessState {
		} else if model.syncState is ErrorState {
      if let errorState = model.syncState as? ErrorState {
        showError(error: errorState.error)
      }
		}
	}
	
	func viewEvents() -> Observable<Event> {
		return events.share()
	}
  
  private func checkIfInitialLoadNeeded() {
    if city == City.empty {
      if let cityRepository = cityRepository, let userDefaultsRepository = userDefaultsRepository {
        if userDefaultsRepository.selectedCityId != Int(city.id) {
          // will be done in background
          disposeBag += cityRepository.loadCities()
            .subscribeOn(MainScheduler.asyncInstance)
            .observeOn(MainScheduler.instance)
            .flatMap { items in Observable.from(items) }
            .filter { item in item.id == userDefaultsRepository.selectedCityId }
            .subscribe(onNext: render , onError: showError)
        }
      }
    }
    if todayForecast == TodayForecast.empty {
      events.accept(LoadTodayForecastEvent())
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
  
  private func render(city: City) {
    self.city = city
    viewImageBackground.image = UIImage(named: city.name.lowercased()) // we will pull new image this way
  }
  
  private func checkIfMeasumentChanged() {
    if let userDefaultsRepository = container?.resolve(UserDefaultsRepository.self) {
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
}
