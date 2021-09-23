//
//  FruitCache+Write.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 23.09.2021.
//

import Foundation
import CocoaLumberjackSwift

/// FruitCache write/delete methods
extension FruitCache {
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
}
