//
//  Extensions.swift
//  Weather
//
//  Created by VNGRS on 11.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import Swinject

extension Double {
  
  /// kelvin to celsius
	public func kelvinToCelsius() -> Double {
		return self - 273.15
	}
	
  /// kelvin to fahrenheit
	public func kelvinToFahrenheit() -> Double {
		return kelvinToCelsius() * 1.8 + 32
	}
  
  /// meter per seconds to kilometer per hours
  public func mpsToKmph() -> Double {
    return self * 3.6
  }
  
  /// meter per seconds to miles per hours
  public func mpsToMph() -> Double {
    return mpsToKmph() * 0.62137
  }
}

extension DisposeBag {
	
	static func += (disposeBag: DisposeBag, disposable: Disposable) {
		disposeBag.insert(disposable)
	}
}

extension Observable where Element == Event {
	
	func toIntent(_ block: @escaping (Element) -> Intent) -> Observable<Intent> {
		return self.map(block)
	}
}

extension Observable where Element == Intent {
	
	func toReducer<T>(_ block: @escaping (Element) -> Observable<Reducer<T>>) -> Observable<Reducer<T>> {
    return self.concatMap(block)
	}
}

extension UITableView: PropertyChangable {
	
	/// ui table view default imple
	public func notifyItemsChanged(_ index: Int, size: Int) {
		let paths = toIndexPath(index: index, size: size)
		self.reloadRows(at: paths, with: .automatic)
	}
	
	public func notifyItemsRemoved(_ index: Int, size: Int) {
		let paths = toIndexPath(index: index, size: size)
		self.deleteRows(at: paths, with: .automatic)
	}
	
  public func notifyItemsInserted(_ index: Int, size: Int, initial: Bool) {
    if initial {
      self.reloadData()
    } else {
      let paths = toIndexPath(index: index, size: size)
      self.insertRows(at: paths, with: .automatic)
    }
	}
	
	private func toIndexPath(index: Int, size: Int) -> [IndexPath] {
		return Array(index...size).map { position in IndexPath(row: position, section: 0) }
	}
}

extension String {
	
	/// empty string contant what will be used through project
	static let empty = ""
	
	/// capitalize sentances of given string
  public func capitalizeSentance() -> String {
    let start = String(self.prefix(1)).uppercased()
    let leftover = String(self.dropFirst())
    return start + leftover
  }
}

extension DataRequest {
	
	private static func serialize<T: Decodable>(decoder: JSONDecoder) -> DataResponseSerializer<T> {
		return DataResponseSerializer { _, response, data, error in
			if let error = error {
				return .failure(error)
			}
			return decode(decoder: decoder, response: response, data: data)
		}
	}
	
	private static func decode<T: Decodable>(decoder: JSONDecoder, response: HTTPURLResponse?, data: Data?) -> Result<T> {
		let result = Request.serializeResponseData(response: response, data: data, error: nil)
		switch result {
		case .success(let data):
			do {
				let entity = try decoder.decode(T.self, from: data)
				return .success(entity)
			} catch {
				return .failure(error)
			}
		case .failure(let error):
			return .failure(error)
		}
	}
	
	@discardableResult
	public func serialize<T: Decodable>(decoder: JSONDecoder = JSONDecoder(), completion: @escaping (DataResponse<T>) -> Void) -> Self {
		return response(queue: nil, responseSerializer: DataRequest.serialize(decoder: decoder), completionHandler: completion)
	}
}

extension UIViewController {
	
	/// container that holds dependency injection resolvable items for view controllers
  var container: Container? {
    get {
      if let delegate = UIApplication.shared.delegate as? AppDelegate {
        return delegate.container
      }
      return nil
    }
  }
	
	/// attach child view controller to parent view controller as provided in parameter
	func attachParentViewController(viewController: UIViewController) {
		viewController.addChild(self)
		if let view = viewController.view.viewWithTag(0xFF) {
			view.addSubview(self.view)
			self.didMove(toParent: viewController)
		} else {
			fatalError("you can only pass child view controller fo view tag \(0xFF)")
		}
	}
	
	/// detach child view controller from it's perent view controller
	func detachParentViewController() {
		self.willMove(toParent: nil)
		self.view.removeFromSuperview()
		self.removeFromParent()
	}
  
  /// showing error on any view controller instance
  func showError(error: Error) {
    let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
    self.present(alertController, animated: true, completion: nil)
  }
}

extension UIColor {
	
	/// bright blue color as #0054ED hex
	static var brightBlue: UIColor {
		get {
			return UIColor.parse(0x0054ED)
		}
	}
	
	/// plae grey color as #ECF0F8 hex
	static var paleGrey: UIColor {
		get {
			return UIColor.parse(0xECF0F8)
		}
	}
	
	/// color parse func that parses 0xFFFFFF representation of int into UIColor
  static func parse(_ color: Int) -> UIColor {
    return parse((color >> 16) & 0xFF, (color >> 8) & 0xFF, (color & 0xFF))
  }
	
	/// color parse sub function that will convert int (0 - 255) for each channel
  static func parse(_ red: Int, _ green: Int, _ blue: Int) -> UIColor {
    return parse(red, green, blue, 1)
  }
	
	/// color parse sub function that will convert int (0 - 255) for each channel with alpha
  static func parse(_ red: Int, _ green: Int, _ blue: Int, _ alpha: Int) -> UIColor {
    return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha))
  }
}

extension DailyForecast {
  
  /// tittle with weather and today as items
  public func toDailyTitle() -> String {
    if self == DailyForecast.empty {
      return "N/A"
    }
    return "\(weathers.first?.toDescription() ?? "N/A") on \(self.toToday())"
    
  }
  
  /// day of week as string
  public func toToday() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    // convert to date obj
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
    // format the date obj
    return dateFormatter.string(from: date)
  }
  
}

extension TodayForecast {
  
  /// converts temperature into formated style ex: "30 °"
  public func toDegreeString(unit: UnitOfTemperature) -> String {
    if self == TodayForecast.empty {
      return "N/A"
    }
    let temperature = self.main.temperature
    let temperatureAsInt: Int
    switch unit {
      case .celsius:
        temperatureAsInt = Int(temperature.kelvinToCelsius())
        break
      case .fahrenheit:
        temperatureAsInt = Int(temperature.kelvinToFahrenheit())
      break
    }
    return String(format: "%d °", temperatureAsInt)
  }
  
  /// converts direction of wind into String cardinals
  public func degreeToCardinals() -> String {
    let cardinals = ["N", "NE", "E", "SE", "S", "SW", "W", "NW", "N"]
    let position = Int(Darwin.round((self.wind.degree.truncatingRemainder(dividingBy: 360))) / 45)
    return cardinals[position]
  }
  
  /// to city name or NA
  public func toCityName() -> String {
    if self == TodayForecast.empty {
      return "N/A"
    }
    return self.name
  }
  
  /// to unit of length proeprty or NA
  public func toLengthString(unit: UnitOfLength) -> String {
    if self == TodayForecast.empty {
      return "N/A"
    }
    let lengthAsInt = Int(wind.toLength(unit: unit))
    switch unit {
      case .metric:
        return String(format: "%d km/h", lengthAsInt)
      case .imperial:
        return String(format: "%d m/h", lengthAsInt)
    }
  }
  
  /// humity string
  public func toHumidty() -> String {
    if self == TodayForecast.empty {
      return "N/A"
    }
    return "\(Int(self.main.humidity))%"
  }
  
  /// to rain string
  public func toRain() -> String {
    if rain == Rain.empty || rain == nil {
      return "N/A"
    }
    return "\(self.rain?.percentage ?? 0) mm"
  }
}

extension Weather {
  
  /// converts string of weather icon into open weather image url for fetch
  public func toIconUrl() -> String {
    return "http://openweathermap.org/img/w/\(icon).png"
  }
  
  /// description capitalized
  public func toDescription() -> String {
    if self == Weather.empty {
      return "N/A"
    }
    return description.capitalizeSentance()
  }
}

extension Tempereture {
  
  /// converts temperature into formated style ex: "30 °C" or "30 °F"
  public func toDegreeString(unit: UnitOfTemperature) -> String {
    switch unit {
    case .celsius:
      return String(format: "%d °C", Int(day.kelvinToCelsius()))
    case .fahrenheit:
      return String(format: "%d °F", Int(day.kelvinToFahrenheit()))
    }
  }
}

extension Wind {
  
  /// parse meter per seconds into required format
  public func toLength(unit: UnitOfLength) -> Double {
    switch unit {
      case .metric:
        return speed.mpsToKmph()
      case .imperial:
        return speed.mpsToMph()
    }
  }
}

extension Sys {
  
  /// will create sunrise string for us
  public func toSunrise() -> String {
    if self == Sys.empty {
      return "N/A"
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm a"
    // init with date
    let date = Date(timeIntervalSince1970: TimeInterval(self.sunrise))
    return dateFormatter.string(from: date)
  }
}
