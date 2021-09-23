//
//  FruitManager.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 20.09.2021.
//

import Foundation
import MulticastDelegateSwift_iOS
import CocoaLumberjackSwift

protocol FruitManagerObserver {
	func fruitManager(_ fruitManager: FruitManager, didCacheFruits: [Fruit])
}

// Usually the service should contain both read and write operations, because some of the operations should be running on the same queue for synchronization purposes

/// The class purpose is to provide read/write functions related to the Fruit model
class FruitManager: Observable, QueueExecutable {
	
	var queueLabel: String {
		return "com.fruit.manager"
	}
	var queueQoS: DispatchQoS {
		return .userInteractive
	}
	var queue: DispatchQueue!
	private(set) var observers = MulticastDelegate<FruitManagerObserver>()
	@InjectedSafe
	internal var cache: FruitCache
	
	init() {
		self.queue = DispatchQueue(label: queueLabel, qos: queueQoS, attributes: .concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.inherit, target: nil)
	}
}
