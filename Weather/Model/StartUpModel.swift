//
//  StartUpModel.swift
//  Weather
//
//  Created by Fatih Şen on 18.11.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import MVICocoa

public struct StartUpModel: Model {
  public typealias Entity = [City]

  public static let empty = StartUpModel(state: idle, data: [])

  public var state: SyncState
  public var data: [City]

  public func copy(state: SyncState? = nil, data: [City]? = nil) -> StartUpModel {
    return StartUpModel(state: state ?? self.state, data: data ?? self.data)
  }
}
