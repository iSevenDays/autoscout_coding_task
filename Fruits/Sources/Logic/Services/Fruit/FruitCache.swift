//
//  FruitCache.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 20.09.2021.
//

import Foundation
import CocoaLumberjackSwift

class FruitCache {
	
	internal let innerCache: CacheBlock
	
	init(cacheBlock: @escaping CacheBlock) {
		self.innerCache = cacheBlock
	}
	
	init(cache: @escaping CacheBlock) {
		self.innerCache = cache
	}
	
	func cache(fruits: [Fruit]) {
		let container = Container(cache: innerCache)
		
		do {
			try container.write { (transaction) in
				transaction.add(fruits)
			}
		}
		catch let error {
			DDLogError("Error: \(error)")
		}
	}
	
	func getFruits() -> [Fruit] {
		let objects = innerCache().objects(FruitObject.self)
		let result: [Fruit] = objects.compactMap({Fruit(managedObject: $0)})
		return result
	}
}
