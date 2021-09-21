//
//  LogManager.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 20.09.2021.
//

import Foundation
import CocoaLumberjackSwift

class LogManager {
	init() {
		setupLoggers()
	}
	
	func setupLoggers() {
		let osLogger = DDOSLogger.sharedInstance
		
		DDLog.add(osLogger)
	}
}
