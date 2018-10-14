//
//  SyncState.swift
//  Weather
//
//  Created by Fatih Şen on 12.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

public protocol SyncState {}

public struct IdleState: SyncState {}

public struct ProcessState: SyncState {
	public let type: ProcessType
	
	init(_ type: ProcessType) {
		self.type = type
	}
	
	public enum ProcessType {
		case refresh, loadMore, create, update, delete
	}
}

public struct ErrorState: SyncState {
	public let error: Error
	
	init(error: Error) {
		self.error = error
	}
}
