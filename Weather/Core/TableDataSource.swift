//
//  TableDataSource.swift
//  Weather
//
//  Created by Fatih Şen on 15.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import UIKit

public protocol TableViewDataSource: UITableViewDataSource { // TODO implement PropertyChangable here
  associatedtype D
  
  var dataSet: ObservableList<D> { get }
  
  func indentifierForIndexPath(_ indexPath: IndexPath) -> String
  func cellFor(_ tableView: UITableView, indexPath: IndexPath) -> TableViewCell<D>
  func itemAt(_ indextPath: IndexPath) -> D
}

