//
//  InjectedSafe.swift
//
//
//  Created by Anton Sokolchenko on 20.09.2021.
//  Copyright © 2021 Anton Sokolchenko. All rights reserved.
//

import Foundation

// InjectedSafe - the property value is initialized upon a call. Use this wrapper for services that have cyclic reference to each other or in case of crashes.
// Use this by default for Services, they usually have reference to one another.
@propertyWrapper
struct InjectedSafe<Dependency> {
	
	var dependency: Dependency! // Resolved dependency
	
	var wrappedValue: Dependency {
		mutating get {
			if dependency == nil {
				let copy: Dependency = Dependencies.shared.resolve()
				self.dependency = copy // Keep copy
			}
			return dependency
		}
		mutating set {
			dependency = newValue
		}
	}
}
