//
//  Alamofire+Extensions.swift
//  Weather
//
//  Created by VNGRS on 10.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

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
