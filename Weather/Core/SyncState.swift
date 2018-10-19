//
//  SyncState.swift
//  Weather
//
//  Created by Fatih Şen on 12.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

public protocol SyncState {}

public struct IdleState: SyncState, Equatable {}

public struct ProcessState: SyncState, Equatable {
	public let type: ProcessType
	
	init(_ type: ProcessType) {
		self.type = type
	}
	
	public enum ProcessType {
		case refresh, loadMore, create, update, delete
	}
  
  public static func == (lhs: ProcessState, rhs: ProcessState) -> Bool {
    return lhs.type == rhs.type
  }
}

public struct ErrorState: SyncState, Equatable {
	public let error: Error
	
	init(error: Error) {
		self.error = error
	}
  
  public static func == (lhs: ErrorState, rhs: ErrorState) -> Bool {
    return lhs.error.localizedDescription == rhs.error.localizedDescription
  }
}


public let idle = IdleState()
// process state
public let refresh = ProcessState(.refresh)
public let loadMore = ProcessState(.loadMore)
public let create = ProcessState(.create)
public let update = ProcessState(.update)
public let delete = ProcessState(.delete)

