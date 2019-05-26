//
//  Extensions.swift
//  Weather
//
//  Created by Fatih Şen on 11.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import Swinject
import MVICocoa

extension Double {
  
  /// kelvin to celsius
    var kelvinToCelsius: Double {
        return self - 273.15
    }
	
  /// kelvin to fahrenheit
    var kelvinToFahrenheit: Double {
		return kelvinToCelsius * 1.8 + 32
	}
  
  /// meter per seconds to kilometer per hours
    var mpsToKmph: Double {
        return self * 3.6
    }
  
  /// meter per seconds to miles per hours
    var mpsToMph: Double {
        return mpsToKmph * 0.62137
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

extension UIColor {
	
	/// bright blue color as #0054ED hex
	static var brightBlue: UIColor {
		get {
			return UIColor.convert(0x0054ED)
		}
	}
	
	/// plae grey color as #ECF0F8 hex
	static var paleGrey: UIColor {
		get {
			return UIColor.convert(0xECF0F8)
		}
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
        temperatureAsInt = Int(temperature.kelvinToCelsius)
        break
      case .fahrenheit:
        temperatureAsInt = Int(temperature.kelvinToFahrenheit)
      break
    }
    return String(format: "%d °", temperatureAsInt)
  }
  
  /// converts direction of wind into String cardinals
  public func toCardinals() -> String {
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
  
  /// to pressure string if available or N/A
  public func toPressure() -> String {
    if self == TodayForecast.empty {
      return "N/A"
    }
    return String(format: "%d hPa", Int(main.pressure))
  }
}

extension Weather {
  
  /// converts string of weather icon into open weather image url for fetch
  public func toIconUrl() -> String {
    if self == Weather.empty {
      return "N/A"
    }
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
        return String(format: "%d °C", Int(day.kelvinToCelsius))
    case .fahrenheit:
        return String(format: "%d °F", Int(day.kelvinToFahrenheit))
    }
  }
}

extension Wind {
  
  /// parse meter per seconds into required format
  public func toLength(unit: UnitOfLength) -> Double {
    switch unit {
      case .metric:
        return speed.mpsToKmph
      case .imperial:
        return speed.mpsToMph
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

extension Observable where Element == [Int] {
	
	func emmitClosest(title: String) -> Observable<Float> {
		return map { array -> Float in
			let min = array.min(by: { (lhs, rhs) -> Bool in
				return lhs < rhs
			})
			
			return Float(min ?? 0)
		}
	}
	
}
