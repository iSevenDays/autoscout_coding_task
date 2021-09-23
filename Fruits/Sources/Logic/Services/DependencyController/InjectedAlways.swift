//
//  InjectedAlways.swift
//
//
//  Created by Anton Sokolchenko on 20.09.2021.
//  Copyright © 2021 Anton Sokolchenko. All rights reserved.
//

import Foundation

// InjectedAlways - a read only getter.
// The property value is never stored. Use this wrapper for services that are never re-initialized, but have to always use the injected service of the last version.
// Use this by default for AppDelegate/SceneDelegate. In case services are restarted, they will use the latest service instance.
@propertyWrapper
struct InjectedAlways<Dependency> {
	
	var wrappedValue: Dependency {
		
		let copy: Dependency = Dependencies.shared.resolve()
		return copy // Never keep copy
	}
}
