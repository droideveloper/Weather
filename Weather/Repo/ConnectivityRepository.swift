//
//  ConnectivityRepository.swift
//  Weather
//
//  Created by Fatih Şen on 19.10.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation

public protocol ConnectityRepository {
  var isConnectivityAvailable: Bool { get }
}
