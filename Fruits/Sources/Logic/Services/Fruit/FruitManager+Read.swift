//
//  FruitManager+Read.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 20.09.2021.
//

import Foundation

/// FruitManager read methods
extension FruitManager {
	func getFruits(completionQueue: DispatchQueue = .main, completion: FruitsCompletion?) {
		executeOnCacheQueue(isWriteOperation: false) {
			let fruits = self.cache.getFruits()
			completionQueue.async {
				completion?(fruits)
			}
		}
	}
}
