//
//  FruitObject.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 20.09.2021.
//

import Foundation
import RealmSwift

final class FruitObject: Object, Decodable {
	@objc dynamic var name: String = ""
	@objc dynamic var image: String = ""
	@objc dynamic var price: Int = 0
	
	var weight = RealmOptional<Float>()
	
	override static func primaryKey() -> String? {
		return "name"
	}
}

// CascadingDeletable is not supported for this entity, a real-world example may include:
//extension FruitObject: CascadingDeletable {
//	static var propertiesToCascadeDelete: [String] {
//		return ["someObject"]
//	}
//}
