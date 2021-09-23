//
//  Dependency.swift
//  
//
//  Created by Anton Sokolchenko on 20.09.2021.
//  Copyright © 2021 Anton Sokolchenko. All rights reserved.
//

import Foundation

struct Dependency {
	typealias ResolveBlock<T> = () -> T
	
	private(set) var value: Any! // Actual value will be assigned after resolve() call
	private let resolveBlock: ResolveBlock<Any>
	let name: String
	
	init<T>(_ block: @escaping ResolveBlock<T>) {
		resolveBlock = block // Save block for future
		name = String(describing: T.self)
	}
	mutating func resolve() {
		value = resolveBlock()
	}
}
