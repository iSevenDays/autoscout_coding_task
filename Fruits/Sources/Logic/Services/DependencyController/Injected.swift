//
//  Injected.swift
//  
//
//  Created by Anton Sokolchenko on 20.09.2021.
//  Copyright © 2021 Anton Sokolchenko. All rights reserved.
//

import Foundation

// Injected - the property value is initialized immediately and should be used by default in  SwiftUI classes
@propertyWrapper
struct Injected<Dependency> {

	var dependency: Dependency! // Resolved dependency

	init() {
		let copy: Dependency = Dependencies.shared.resolve()
		self.dependency = copy // Keep copy
	}

	var wrappedValue: Dependency {
		get {
			return dependency
		}
		mutating set {
			dependency = newValue
		}
	}
}
