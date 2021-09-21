//
//  Dependencies.swift
//  
//
//  Created by Anton Sokolchenko on 20.09.2021.
//  Copyright © 2021 Anton Sokolchenko. All rights reserved.
//

import Foundation

/// The dependencies management container is responsible for:
/// Dependency container will manage added Depenedency objects.
/// Register given Dependency in container;
/// Build resolved dependencies list;
/// Resolve single dependency of given type.
/// Hints in the code below explain:
/// 1 Main access point to the container;
/// 2 List of available dependencies to be resolved and accessed;
/// 3 Once initial resolve is complete we have to update shared value.
class Dependencies {

	@resultBuilder struct DependencyBuilder {
		static func buildBlock(_ dependency: Dependency) -> Dependency { dependency }
		static func buildBlock(_ dependencies: Dependency...) -> [Dependency] { dependencies }
	}

	convenience init(@DependencyBuilder _ dependencies: () -> [Dependency]) {
		self.init()
		dependencies().forEach { register($0) }
	}

	convenience init(@DependencyBuilder _ dependency: () -> Dependency) {
		self.init()
		register(dependency())
	}
	private let buildSemaphore = DispatchSemaphore(value: 0)
	// Queue for accessing resolve() method after the build() is finished. Without this queue
	// the build() may not finish before resolve() and resolve() will be called with unset dependencies
	private let buildQueue = DispatchQueue(label: "dependencies.buildQueue", attributes: .concurrent)

	// Queueu for accessing dependencies
	private let isolationQueue = DispatchQueue(label: "dependencies.isolationQueue", attributes: .concurrent)
	
	// Key is used to prevent reference cyle when calling buildQueue inside buildQueue.
	// If key is not found in the current queue - we will dispatch it to the buildQueue to sync the calls
	private let buildQueueKey = DispatchSpecificKey<Void>()

	static var shared = Dependencies() // 1

	private var _dependencies: [Dependency] = []
	fileprivate var dependencies: [Dependency] {
		get {
			return isolationQueue.sync { _dependencies }
		}
		set { // 2
			isolationQueue.async(flags: .barrier) {
				self._dependencies = newValue
			}
		}
	}

	init() {
		buildQueue.setSpecific(key: buildQueueKey, value: ())
	}

	/// Adding dependency to dependencies array
	/// - Parameters:
	///   - dependency: dependency block
	///   - insert: if true will insert in the begin of array otherwhise in the end of dependencies array

	func register(_ dependency: Dependency, insert: Bool = false) {
		// Avoid duplicates
		guard dependencies.firstIndex(where: { $0.name == dependency.name }) == nil else {
			debugPrint("\(String(describing: dependency.name)) already registered, ignoring")
			return
		}
		print("Will register dependency: \(dependency)")
		if insert {
			dependencies.insert(dependency, at: 0)
		} else {
			dependencies.append(dependency)
		}
	}

	func register(_ dependency: Dependency, insertAtIndex: Int) {
		// Avoid duplicates
		guard dependencies.firstIndex(where: { $0.name == dependency.name }) == nil else {
			debugPrint("\(String(describing: dependency.name)) already registered, ignoring")
			return
		}
		print("Will register dependency: \(dependency)")
		dependencies.insert(dependency, at: insertAtIndex)
	}

	func unregister(_ dependency: Dependency) {
		// Avoid duplicates
		guard let index = dependencies.firstIndex(where: { $0.name == dependency.name })  else {
			debugPrint("\(String(describing: dependency.name)) is not registered, ignoring")
			return
		}

		dependencies.remove(at: index)
	}

	/// Build method can be called multiple times in unit tests, that's why we use semaphores
	func build(completion: (() -> Void)?) {
		// We assuming that at this point all needed dependencies are registered

		buildQueue.async(flags: .barrier) {
			// print("BUILD started")

			for index in self.dependencies.startIndex..<self.dependencies.endIndex {
				self.dependencies[index].resolve()
			}
			// signal that dependencies are ready to be used
			self.buildSemaphore.signal()
			completion?()
		}
	}

	func stopBuild(completion: @escaping () -> Void) {
		buildQueue.async(flags: .barrier) {
			completion()
		}
	}

	func resolve<T>() -> T {
		if DispatchQueue.getSpecific(key: buildQueueKey) != nil {
			// we are inside queue
			return unsafeResolve()
		}
		buildSemaphore.wait()
		return buildQueue.sync {
			let result: T = self.unsafeResolve()
			self.buildSemaphore.signal()
			return result
		}
	}

	func unsafeResolve<T>() -> T {
		guard let dependency = dependencies.first(where: { $0.value is T })?.value as? T else {
			fatalError("Can't resolve \(T.self). \(T.self) is not initialized. Consider using @InjectedSafe private var \(T.self) instead of @Injected private var \(T.self) or change the dependencies order to initialize dependent services later.")
		}
		return dependency
	}

	// MARK: - Unit Tests support
	internal var unitTestsMode: Bool {
		return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
	}
	// Method for UNIT TESTS ONLY
	internal var getInternalDependencies: [Dependency] {
		guard unitTestsMode else {
			fatalError("Error prohibited usage of the method outside unit tests")
		}
		return dependencies
	}
}

/// If we need to manipulate on set of injected dependencies we can make dependency container conform to Sequence protocol:
extension Dependencies: Sequence {
	/// Example usage:
	/// to find all dependencies of given protocol and do what we want:
	//	protocol Resettable { func reset() }
	//		 Dependencies.shared
	//	 .compactMap { $0 as? Resettable }
	//	 .forEach { $0.reset() }
	func makeIterator() -> AnyIterator<Any> {
		var iter = dependencies.makeIterator()
		return AnyIterator { iter.next()?.value }
	}
}
