//
//  Endpoint.swift
//  Weather
//
//  Created by VNGRS on 9.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import Alamofire

protocol Requestable {
    
    var baseUrl: String { get }
    var request: (HTTPMethod, URLConvertible) { get }
}
