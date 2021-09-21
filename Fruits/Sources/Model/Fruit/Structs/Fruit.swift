//
//  Fruit.swift
//  Fruits
//
//  Created by Anton Sokolchenko on September 7, 2021.
//

import SwiftUI

struct Fruit: Identifiable, Decodable {
	var id: String {
		return name
	}
	var name: String
	
	// it is URL string
	var image: String
	var price: Int
	var weight: Float?
}

extension Fruit: Persistable {
	public init(managedObject: FruitObject) {
		name = managedObject.name
		image = managedObject.image
		price = managedObject.price
		weight = managedObject.weight.value
	}
	
	func managedObject() -> FruitObject {
		let managedObject = FruitObject()
		managedObject.name = name
		managedObject.image = image
		managedObject.price = price
		managedObject.weight.value = weight
		return managedObject
	}
}

extension Fruit: Equatable {

}

extension Fruit: CustomStringConvertible {
	var description: String {
		let str = "Fruit id: \(id), name: \(name), price: \(price), weight: \(String(describing: weight)), image: \(image)"
		return str
	}
}

extension Fruit: PrimaryKeySupportable {
	var primaryKey: String {
		return id
	}
}
func == (lhs: Fruit, rhs: Fruit) -> Bool {
	// usually we compare by id, but we only have name
	return lhs.name == rhs.name
}
