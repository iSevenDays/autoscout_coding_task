//
//  DependenciesBuilder.swift
//  
//
//  Created by Anton Sokolchenko on 20.09.2021.
//  Copyright © 2021 Anton Sokolchenko. All rights reserved.
//

import Foundation
import RealmSwift

/// The class purpose is to build the dependencies that are used in the application
class DependenciesBuilder {
	
	static let shared = DependenciesBuilder()
	
	internal var unitTestsMode: Bool {
		return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
	}
	
	init() {
		initializeDefaultDependencies()
	}
	
	enum AdditionalDependenciesInitializationOrder {
		case first// initialize all dependencies before other default dependencies
		case last  // initialize all dependencies after default dependencies
		case order(customOrder: [AdditionalDependenciesInitializationOrder]) // array of last/first values
		case after(AnyClass) // initialize after the specific class
	}
	
	/// Initialize dependencies for production or unit test with additional dependencies in the specified order
	/// - Parameters:
	///   - additionalDependenciesIntializationOrder: initialiation order of the additional dependencies - some of the must be initialized first, some of them can be initialized later, can be override with custom initialization order
	///   - dependencies: additional dependencies for unit tests
	func initializeDefaultDependencies(additionalDependenciesIntializationOrder: AdditionalDependenciesInitializationOrder = .last, withAdditionaDependencies dependencies: Dependency...) {
		
		let cacheBlock = RealmSharedCache.shared.realmCacheBlock()
		Dependencies.shared = getDependencies(cacheBlock: cacheBlock)
		
		var index = 0
		dependencies.forEach { dependency in
			switch additionalDependenciesIntializationOrder {
			case .first:
				assert(false, "unsupported for test project")
			case .last:
				Dependencies.shared.register(dependency, insert: false)
			case .after(_):
				assert(false, "unsupported for test project")
			case .order(_):
				assert(false, "unsupported for test project")
				
				index += 1
			}
		}
		Dependencies.shared.build {}
	}
	
	private func getDependencies(cacheBlock: @escaping () -> Realm) -> Dependencies {
		
		return Dependencies {
			Dependency { LogManager() }
			Dependency { FruitCache(cacheBlock: cacheBlock) }
			Dependency { FruitsProvider() }
			Dependency { FruitManager()}
			Dependency { ContentViewBusinessLogic() }
		}
	}
	
}
