//
//  FruitCache+Read.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 23.09.2021.
//

import Foundation
import CocoaLumberjackSwift

/// FruitCache read methods
extension FruitCache {
	func getFruits() -> [Fruit] {
		let objects = innerCache().objects(FruitObject.self)
		let result: [Fruit] = objects.compactMap({Fruit(managedObject: $0)})
		return result
	}
}
