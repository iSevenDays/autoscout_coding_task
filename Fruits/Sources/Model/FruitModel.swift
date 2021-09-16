//
//  FruitModel.swift
//  Fruits
//
//  Created by Anton Sokolchenko on September 7.
//

import SwiftUI

struct DefaultIdentifier: DefaultCodableStrategy {
	static var defaultValue: String { return UUID().uuidString }
}

struct Fruit: Identifiable, Decodable {
	// a local property to support saving of this entites to the database
	// usually, this identifier is retrived from the backend or set locally if the struct is created locally
	// the property is not present in the gist, but it is very rare if 'id' is not present
	@DefaultCodable<DefaultIdentifier>
	var id: String = DefaultIdentifier.defaultValue
	
	var name: String
	
	// it is URL string
	var image: String
	var price: Int
	var weight: Float?
}

