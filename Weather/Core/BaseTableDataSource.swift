//
//  BaseTableDataSource.swift
//  Weather
//
//  Created by Fatih Şen on 16.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import UIKit

open class BaseTableDataSource<T>: NSObject, TableViewDataSource {
  public typealias D = T
  
  public var dataSet: ObservableList<T>
  
  init(dataSet: ObservableList<T>) {
    self.dataSet = dataSet
  }
  
  public func indentifierForIndexPath(_ indexPath: IndexPath) -> String {
    return String.empty
  }
  
  public func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSet.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return cellFor(tableView, indexPath: indexPath)
  }
}
