//
//  TableViewCell.swift
//  Weather
//
//  Created by Fatih Şen on 15.10.2018.
//  Copyright © 2018 VNGRS. All rights reserved.
//

import Foundation
import UIKit

open class TableViewCell<D>: UITableViewCell {
  
  open func bind(entity: D) {
    /* no opt */
  }
  
  open func unbind() {
    /* no opt */
  }
}
