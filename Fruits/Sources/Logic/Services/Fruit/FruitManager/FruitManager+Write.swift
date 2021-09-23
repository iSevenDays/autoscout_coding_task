//
//  FruitManager+Write.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 20.09.2021.
//

import Foundation
import CocoaLumberjackSwift

typealias FruitsCompletion = (([Fruit]) -> Void)

/// FruitManager write/delete methods
extension FruitManager {
	func cache(fruits: [Fruit], completionQueue: DispatchQueue = .main, completion: FruitsCompletion?) {
		executeOnCacheQueue(isWriteOperation: true) { [weak self] in
			guard let self = self else {
				completionQueue.async {
					completion?([])
				}
				return
			}
			self.cache.cache(fruits: fruits)
			DDLogDebug("Did cache fruits: \(fruits)")
			DispatchQueue.main.async {
				self.observers.invokeDelegates { (observer) in
					observer.fruitManager(self, didCacheFruits: fruits)
				}
				completionQueue.async {
					completion?(fruits)
				}
			}
		}
	}
}
