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
	
	public func kelvinToCelsius() -> Double {
		return self - 273.15
	}
	
	public func kelvinToFahrenheit() -> Double {
		return kelvinToCelsius() * 1.8 + 32
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
	
	static let empty = ""
  
  public func capitalizeSentance() -> String {
    let start = String(self.prefix(1)).uppercased()
    let leftover = String(self.dropFirst())
    return start + leftover
  }
  
  public func toWeatherIconUrl() -> String {
    return "http://openweathermap.org/img/w/\(self).png"
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
  
  var container: Container? {
    get {
      if let delegate = UIApplication.shared.delegate as? AppDelegate {
        return delegate.container
      }
      return nil
    }
  }
}

extension UIColor {
  
  static func parse(_ color: Int) -> UIColor {
    return parse((color >> 16) & 0xFF, (color >> 8) & 0xFF, (color & 0xFF))
  }
  
  static func parse(_ red: Int, _ green: Int, _ blue: Int) -> UIColor {
    return parse(red, green, blue, 1)
  }
  
  static func parse(_ red: Int, _ green: Int, _ blue: Int, _ alpha: Int) -> UIColor {
    return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha))
  }
}
