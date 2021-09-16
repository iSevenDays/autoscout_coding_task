//
//  FruitData.swift
//  Fruits
//
//  Created by Anton Sokolchenko on 07.09.2021.
//

import SwiftUI

// MARK: - FRUIT DATA

let fruitsData: [Fruit] = [
	Fruit(
		name: "Blueberry",
		image: Assets.blueberry.name,
		price: 35
	),
	Fruit(
		name: "Strawberry",
		image: Assets.strawberry.name,
		price: 12
	),
	Fruit(
		name: "Grapes",
		image: Assets.grapefruit.name,
		price: 45,
		weight: 0.1),
	Fruit(
		name: "Pear",
		image: Assets.pear.name,
		price: 200)
]
let fruitsDataViewModels: [FruitViewModel] = fruitsData.compactMap({FruitViewModel(fruit: $0)})
