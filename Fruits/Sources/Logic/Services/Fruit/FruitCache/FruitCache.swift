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
}
