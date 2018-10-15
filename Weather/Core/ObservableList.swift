//
//  ObservableList.swift
//  Weather
//
//  Created by Fatih Şen on 14.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation

public class ObservableList<T> {
	
	private var dataSet = Array<T>()
	private var protocols = Array<PropertyChangable>()
	
	public var count: Int {
		get {
			return dataSet.count
		}
	}
	
	public func register(_ callback: PropertyChangable) {
		let index = protocols.firstIndex(where: { listener in
			return listener === callback
		})
		if index == nil {
			protocols.append(callback)
		}
	}
	
	public func unregister(_ callback: PropertyChangable) {
		let index = protocols.firstIndex(where: { listener in
			return listener === callback
		})
		if let index = index {
			protocols.remove(at: index)
		}
	}
	
	public func append(_ value: T) {
		let index = dataSet.count
		dataSet.append(value)
		notifyInsert(index, size: 1)
	}
	
	public func append(_ values: [T]) {
		let index = dataSet.count
		dataSet.append(contentsOf: values)
		notifyInsert(index, size: values.count)
	}
	
	public func insert(_ value: T, at: Int) {
		dataSet.insert(value, at: at)
		notifyInsert(at, size: 1)
	}
	
	public func insert(_ values: [T], at: Int) {
		dataSet.insert(contentsOf: values, at: at)
		notifyInsert(at, size: values.count)
	}
	
	public func remove(at: Int) {
		dataSet.remove(at: at)
		notifyRemove(at, size: 1)
	}
	
	public func removeAll() {
		dataSet.removeAll()
		notifyRemove(0, size: dataSet.count)
	}
	
	public func put(at: Int, value: T) {
		dataSet[at] = value
		notifyChange(at, size: 1)
	}
	
	private func notifyInsert(_ index: Int, size: Int) {
		protocols.forEach { listener in listener.notifyItemsInserted(index, size: size) }
	}
	
	private func notifyRemove(_ index: Int, size: Int) {
		protocols.forEach { listener in listener.notifyItemsRemoved(index, size: size) }
	}
	
	private func notifyChange(_ index: Int, size: Int) {
		protocols.forEach { listener in listener.notifyItemsChanged(index, size: size) }
	}
}
