//
//  Persistable.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 20.09.2021.
//

import Foundation
import RealmSwift

public protocol Persistable {
	associatedtype ManagedObject: RealmSwift.Object
	init(managedObject: ManagedObject)
	func managedObject() -> ManagedObject
}
