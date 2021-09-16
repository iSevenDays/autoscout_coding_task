//
//  FruitViewModel.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 07.09.2021.
//

import Foundation


/// The ViewModel that is directly mapped to SwiftUI classes
struct FruitViewModel: Identifiable {
	
	private var fruit: Fruit
	
	var id: String {
		return fruit.id
	}
	var name: String {
		return fruit.name
	}
	var image: String {
		return fruit.image
	}
	
	var price: String {
		return L10n.Fruit.price(self.fruit.price)
	}
	var weight: String? {
		if let weight = self.fruit.weight {
			return L10n.Fruit.weight(weight)
		}
		return nil
	}
	
	init(fruit: Fruit) {
		self.fruit = fruit
	}
}
