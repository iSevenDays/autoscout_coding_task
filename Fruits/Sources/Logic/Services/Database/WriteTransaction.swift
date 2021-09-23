//
//  WriteTransaction.swift
//  
//
//  Created by Anton Sokolchenko on 20.09.2021.
//  Copyright © 2021. All rights reserved.
//

import Foundation
import RealmSwift
// In real-world scenario each module conforms to LoggingModuleProtocol and has its own flag to enable/disable logging
import CocoaLumberjackSwift

public protocol PrimaryKeySupportable {
	var primaryKey: String { get }
}

public final class WriteTransaction {
	private let realm: Realm
	internal init(realm: Realm) {
		self.realm = realm
	}
	public func add<T: Persistable>(_ value: T) {
		DDLogDebug("Will cache 1 item of type \(T.self)")
		realm.add(value.managedObject(), update: .all)
	}
	public func add<T: Persistable>(_ values: [T]) {
		DDLogDebug("Will cache \(values.count) items of type \(T.self)")
		realm.add(values.compactMap({$0.managedObject()}), update: .all)
	}
	
	public func remove<T: Persistable & PrimaryKeySupportable>(_ value: T, cascadingDelete: Bool = false) {
		guard let object = realm.object(ofType: T.ManagedObject.self, forPrimaryKey: value.primaryKey) else {
			DDLogError("Couldn't find object to remove of type \(T.ManagedObject.self) for primaryKey: \(value.primaryKey)")
			return
		}
		if cascadingDelete {
			assert(false, "Unsupported feature")
			// I dont' include support for this example project
			// realm.cascadingDelete(object)
		} else {
			realm.delete(object)
		}
	}
	
	/// Remove Realm objects with optional transation verification
	/// - Parameters:
	///   - value: Realm Object
	///   - verifyTransaction: true if transation should be verified, false if not
	///   - cascadingDelete: use true for cascading delete, should be used by default or skipped when cascading delete is not needed
	public func remove<T: Object>(_ value: T, verifyTransaction: Bool = true, cascadingDelete: Bool = false) {
		if verifyTransaction {
			if let primaryKeyProperty = T.primaryKey(), let primaryKeyValue = value.value(forKey: primaryKeyProperty) as? String {
				guard realm.object(ofType: T.self, forPrimaryKey: primaryKeyValue) != nil else {
					DDLogError("Couldn't find object to remove of type \(T.self) for primaryKey: \(primaryKeyValue)")
					return
				}
			} else {
				DDLogError("Couldn't find object to remove of type \(T.self). reason: primaryKey is not a String or nil")
			}
		}
		if cascadingDelete {
			assert(false, "Unsupported feature")
			// I dont' include support for this example project
			// realm.cascadingDelete(value)
		} else {
			realm.delete(value)
		}
	}
	
}
