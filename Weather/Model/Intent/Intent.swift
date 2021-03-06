//
//  Intent.swift
//  Weather
//
//  Created by Fatih Şen on 12.11.2018.
//  Copyright © 2018 Open Source. All rights reserved.
//

import Foundation
import MVICocoa

public typealias Operation = MVICocoa.Operation

public let loadSetting = Operation(0x02)
public let selectSetting = Operation(0x03)
public let selectCity = Operation(0x04)
public let selectTab = Operation(0x05)
