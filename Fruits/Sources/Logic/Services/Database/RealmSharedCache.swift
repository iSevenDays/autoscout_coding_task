//
//  RealmSharedCache.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 20.09.2021.
//

import Foundation
import RealmSwift

/// The class provides a shared realm cache for services
class RealmSharedCache {
	static let shared = RealmSharedCache()

	private func realmMigrationSupportConfiguration() -> Realm.Configuration {
		// Update version if new properties are added to Realm
		let config = Realm.Configuration(schemaVersion: 0) { (migration, oldSchemaVersion) in
			// We haven’t migrated anything yet, so oldSchemaVersion == 0
			if oldSchemaVersion <= 1 {
				print("Found old schema, will implement automatic migration from oldSchemaVersion: \(oldSchemaVersion)")
			}
		}
		return config
	}
	
	func realmCacheBlock() -> () -> Realm {
		let cacheBlock = { () -> Realm in
			do {
				let configuration = self.realmMigrationSupportConfiguration()
				let realm = try Realm(configuration: configuration)
				realm.refresh()
				return realm
			} catch let error {
				fatalError("\(error)")
			}
		}
		return cacheBlock
	}
}

