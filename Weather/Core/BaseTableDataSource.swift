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
  
  public func cellFor(_ tableView: UITableView, indexPath: IndexPath) -> TableViewCell<D> {
    let key = indentifierForIndexPath(indexPath)
    let cell = tableView.dequeueReusableCell(withIdentifier: key, for: indexPath)
    if let cellable = cell as? TableViewCell<D> {
      cellable.setUp() // we do call set up for change in styles
      cellable.bind(entity: itemAt(indexPath))
      return cellable
    }
    fatalError("you should implement 'TableViewCell<D>' protocol to use this")
  }
  
  public func itemAt(_ indexPath: IndexPath) -> D {
    return dataSet.get(indexPath.row)
  }
}
