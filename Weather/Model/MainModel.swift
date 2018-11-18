//
//  MainModel.swift
//  Weather
//
//  Created by Fatih Şen on 18.11.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import MVICocoa

public struct MainModel: Model {
	public typealias Entity = [Tab]

  public static let empty = MainModel(state: idle, data: [])

  public var state: SyncState
	public var data: [Tab]

  public func copy(state: SyncState? = nil, data: [Tab]? = nil) -> MainModel {
    return MainModel(state: state ?? self.state, data: data ?? self.data)
  }
}
