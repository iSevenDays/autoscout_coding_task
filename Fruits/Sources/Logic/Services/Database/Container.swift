//
//  Container.swift
//  
//
//  Created by Anton Sokolchenko on 20.09.2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import RealmSwift

public final class Container {
	private let innerCache: CacheBlock

	init(cache: @escaping CacheBlock) {
		self.innerCache = cache
	}
	
	public func write(_ block: (WriteTransaction) throws -> Void)
		throws {
			let realm = innerCache()
			let transaction = WriteTransaction(realm: realm)
			try realm.write {
				try block(transaction)
			}
	}
}
