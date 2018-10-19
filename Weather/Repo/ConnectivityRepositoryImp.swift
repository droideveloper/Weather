//
//  ConnectivityRepositoryImp.swift
//  Weather
//
//  Created by Fatih Şen on 19.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import Alamofire

class ConnectityRepositoryImp: ConnectityRepository {
 
  public var isConnectivityAvailable: Bool {
    get {
      if let networkReachabilityManager = NetworkReachabilityManager() {
        return networkReachabilityManager.isReachable
      }
      return false
    }
  }
}
